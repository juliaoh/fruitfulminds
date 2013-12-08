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
end
