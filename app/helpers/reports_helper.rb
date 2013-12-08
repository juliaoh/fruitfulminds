module ReportsHelper
  def initialize_fields_in_report
    #A course is uniquely defined by
    #1) School ID (number)
    #2) Semester (string)
    #3) Curriculum ID (number), curriculum corresponds to survey
    #Example: 1, 'Fall 2013', 1 could correspond to Ascend Elementary, 'Fall 2013', 5th Grade Curriculum

    #A course has
    #a list of its ambassadors (list of user ids)
    #presurvey data (id)
    #postsurvey data (id)
    #total_students (int)
    @course_total = @course.total_students
    @presurvey_subtotal = 0
    @postsurvey_subtotal = 0
    @school = School.find_by_id(@course.school_id)
    @school_name = @school.name
    @school_semester = @course.semester
    @main_semester_title = @school_semester + " Report"
    @static_contents = StaticContent.first
    @curriculum = Curriculum.find_by_id(@course.curriculum_id)
    @questions = {}
    @warnings = []
    @warning_flag = false
    #presurvey.total & postsurvey.total are hashes of
    #{user_id => {'total' => # of students user is entering data for}}
    @presurvey = Presurvey.find_by_id(@course.presurvey_id)
    @postsurvey = Postsurvey.find_by_id(@course.postsurvey_id)
  end

  def warn_incomplete_report
    if @presurvey.nil? and @postsurvey.nil?
      flash[:warning] = "Empty presurvey and postsurvey results. Cannot generate report."
      redirect_to "/reports/new" and return true
    elsif @presurvey.nil?
      flash[:warning] = "Empty presurvey results. Cannot generate report."
      redirect_to "/reports/new" and return true
    elsif @postsurvey.nil?
      flash[:warning] = "Empty postsurvey results. Cannot generate report."
      redirect_to "/reports/new" and return true
    end
    return false
  end

  def populate_data(presurvey_data, postsurvey_data, data, comps)
    presurvey_data.keys.each do |q_id|
      #q_id is same for both presurvey & postsurvey questions
      pre_value = presurvey_data[q_id]
      post_value = postsurvey_data[q_id]
      delta = post_value - pre_value
      #not considered a weakness if starting value is 90%
      possible_weakness = (((pre_value >= 80) and (post_value < 80)) or pre_value < 80)
      if (pre_value >= 80 and post_value >= 80)
        question = Question.find_by_id(q_id)
        comps[question.name] = question.msg
      end
      info_list = [q_id, delta, possible_weakness]
      data.push(info_list)
    end
  end

  def populate_strengths(sorted_data, strengths)
    sorted_data[0..4].each do |info_list|
      question = Question.find_by_id(info_list[0])
      if info_list[1] > 0 #infolist[1]  is the delta
        strengths[question.name] = question.msg
      end
    end
  end

  def populate_weaknesses(sorted_data, weaknesses, strengths)
    weak_count = 0
    index = sorted_data.size - 1
    while weak_count < 5 do #need 5 weaknesses
      break if index < 0
      info_list = sorted_data[index]
      if info_list[2] #check if possible to be weakness
        question = Question.find_by_id(info_list[0])
        if not strengths.include?(question.name)
          weaknesses[question.name] = question.msg #message
          weak_count = weak_count + 1
        end
      end
      index = index - 1
    end
  end

  def get_all_questions_of_type(type)
    @questions[type] = []
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != type
      section.questions.each do |q_id|
        question = Question.find_by_id(q_id)
        @questions[type].push(question)
      end
    end
  end

  def calc_values(data, data_hash, combined_subtotal)
    #helper function
    #data expected to be from @presurvey.data[user.id] or @postsurvey.data[user.id]
    return data_hash if data.nil?
    data.keys.each do |q_id|
      question = Question.find_by_id(q_id)
      next if question.qtype != @type #skips if not type: 'Efficacy' or 'Multiple Choice'

      #value is (ratio of correct answers entered to combined SUB_totals number of students) * 100
      value = (data[q_id]/combined_subtotal.to_f) * 100
      if data_hash.include?(q_id)
        data_hash[q_id] += value
      else
        data_hash[q_id] = value
      end
    end
    return data_hash
  end

  def extract_data_list(presurvey_data, postsurvey_data)
    @course.users.each do |user|
      user_pre_data = @presurvey.data[user.id]
      user_post_data = @postsurvey.data[user.id]
      #following code works because of invariant:
      #pre&post surveys have the exact same questions
      if not @presurvey.total[user.id].nil?
        @presurvey_subtotal += @presurvey.total[user.id]
      end
      if not @postsurvey.total[user.id].nil?
        @postsurvey_subtotal += @postsurvey.total[user.id]
      end

      #calc_values is in ReportsHelper
      presurvey_data = calc_values(user_pre_data, presurvey_data, @presurvey_total)
      postsurvey_data = calc_values(user_post_data, postsurvey_data, @postsurvey_total)
    end

    data = [presurvey_data, postsurvey_data]

    return data
  end

end
