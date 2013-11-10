#temporary file, will replace reports_controller.rb later
#some things that I haven't done (doesn't include everything):
#calculate_improvement - calculates overall % improvement for MC/objective sections
#calculate size of graph based on # of sections in generate_objective_graph
#add overall improvement graph (for objective/mc)
#add efficacy graph

class ReportsController < ApplicationController
  def new
    #New report page should only list the classes that the ambassador is part of
    @classes = @current_user.classes

  end

  def create
    #user selects which class to generate a report for
    @class = Class.find_by_id(params[:class])
    #@report = Report.create!(:class_id => @class.id)
    generate_text
  end

  #grammar
  #returns 'was' or 'were' depending on size
  def was_were(size)
    if size == 1
      return 'was'
    elsif size > 1
      return 'were'
    else
      return 'was'
    end
  end

  def generate_text
    if (defined?(@class)).nil?
      flash[:warning] = "@class is not defined"
      return
    end

    #A class is uniquely defined by 
    #1) School ID (number)
    #2) Semester (string)
    #3) Curriculum ID (number), curriculum corresponds to survey
    #Example: 1, 'Fall 2013', 1 could correspond to Ascend Elementary, 'Fall 2013', 5th Grade Curriculum

    #A class has 
    #a list of its ambassadors (list of user ids)
    #presurvey data (id)
    #postsurvey data (id)
    #total_students (int)
    @school = School.find_by_id(@class.school_id)
    @school_name = @school.name
    @school_semester = @class.school_semester
    @curriculum = Curriculum.find_by_id(@class.curriculum_id)
    #presurvey.total & postsurvey.total are hashes of
    #{user_id => {'total' => # of students user is entering data for}}
    @presurvey = Presurvey.find_by_id(@class.presurvey_id)
    @postsurvey = Postsurvey.find_by_id(@class.postsurvey_id)

    @presurvey_total = 0
    @postsurvey_total = 0
    @presurvey.total.values.each do |subtotal|
      @presurvey_total += subtotal #adds number of students user_id is entering data for
    end

    @postsurvey.total.values.each do |subtotal|
      @postsurvey_total += subtotal
    end
    generate_intro_text
  end


  def generate_intro_text
    @ambassadors = ""
    @class.users.each do |user_id|
      @ambassadors += User.find_by_id(user_id).name + ", "
    end

    @college = User.find_by_id(@class.users[0]).college.name

    @main_title = "Fruitful Minds #{@school_name} #{@school_semester} Report"
    @school_intro_title = "Fruitful Minds at #{@school_name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school_name} during #{@school_semester}" 
    @school_intro_second = "    #{@class.users.size} students from #{@college} #{was_were(@class.users.size)} selected as Fruitful Minds ambassadors"
    @school_intro_third = "    During each 50-minute lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
    @eval_intro_first = "Prior to the 7-week curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
    @efficacy = calculate_improvement
    @eval_intro_second = "On average, students have shown a #{@efficacy}% improvement after going through seven weeks of classes." 
    @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@school_semester.presurvey_part1s[0].number_students} took the pre-curriculum survey, and #{@school_semester.postsurveys[0].number_students} students took the post-curriculum surveys."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school_name}"
    #generate_strengths
    @ambassadorNoteTitle = "Ambassador Notes: "
    #@objectives is a hash of
    #Section name => objective description
    @objectives = {}
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      section_name = section.name
      section_objective = section.objective
      if section.type != 'Efficacy'
        @objectives[section_name] = section.objective
      end
    end
    @improvement_intro = "#{@presurvey_total} students took the pre-curriculum survey and #{@postsurvey_total} students took the post-curriculum survey. These were not necessarily the same students. However, on average, students showed significant increases in their agreement that they could"
  end


  def generate_pdf
    if not params[:amb_note].blank?
      #make sure ambassador writes some Notes
      session[:amb_note] = params[:amb_note]
      save_pdf
      redirect_to "/reports/#{@file_name}"
      return
    else
      flash[:warning] = "Please enter ambassador notes"
      redirect_to new_report_path and return
    end
  end

  def save_pdf
    @report_note = session[:amb_note]
    file = @school_name.gsub! /\s+/, '_'
    file = file.downcase
    @file_name = "#{file}_report.pdf"
    generate_text
  end


  def generate_objective_graph(data)
    @axes = []
    @labels = ""
    @objectives.keys.each do |section_name|
      @axes.push(section_name)
      @labels += section_name+"|"
    end
    @labels.chomp('|')

    @max = 0
    data.each do |survey_data|
      if survey_data.compact.max > @max
        @max = survey_data
      end
    end
    
    @nutrition_chart = Gchart.bar(:size => '1000x300', 
                                :title => "Average Survey Score in Six Nutrition Topics",
                                :legend => ['Pre', 'Post'],
                                :bar_colors => '3399CC,99CCFF',
                                :data => data,
                                :bar_width_and_spacing => '30,0,23',
                                :axis_with_labels => 'x,y',
                                :axis_labels => [@labels],
                                :stacked => false,
                                :axis_range => [nil, [0,@max,10]]
                                )    


  end

  def generate_data(type)
    #type should be either 'Efficacy' or 'Multiple Choice'
    presurvey_data = {}
    postsurvey_data = {}
    #presurvey.data & postsurvey.data are hashes of
    #{user_id => {q_id => value}} 

    def calc_values(data, data_hash)

      data.keys.each do |q_id|
        question = Questions.find_by_id(q_id)
        next if question.type != type #skips if not type: 'Efficacy' or 'Multiple Choice'

        #value is (ratio of correct answers entered to total number of students) * 100
        value = (data[q_id]/class_total.to_f) * 100
        if data.include?(q_id)
          data_hash[q_id] += value
        else
          data_hash[q_id] = value
        end
      end
      return data_hash
    end

    @class.users.each do |user_id|
      user_pre_data = @presurvey.data[user_id]
      user_post_data = @postsurvey.data[user_id]

      #following code works because of invariant:
      #pre&post surveys have the exact same questions
      presurvey_data = calc_values(user_pre_data, presurvey_data)
      postsurvey_data = calc_values(user_post_data, postsurvey_data)
    end
    data = [presurvey_data, postsurvey_data]
    return data
  end



  def generate_strengths(data_list)
    #method can be used for either efficacy or MC questions
    #data_list is [presurvey_data, postsurvey_data]
    #pre/postsurvey_data is {q_id => percent value}
    presurvey_data = data_list[0]
    postsurvey_data = data_list[1]
    data = []
    
    presurvey_data.keys.each do |q_id|
      #q_id is same for both presurvey & postsurvey questions
      pre_value = presurvey_data[q_id]
      post_value = postsurvey_data[q_id]
      delta = post_value - pre_value
      possible_weakness = ((pre_value < 90) and (delta > 0))
      info_list = [q_id, delta, possible_weakness]
      data.push(info_list)
    end

    #info_list is [q_id, delta, possible_weakness]
    sorted_data = data.sort_by {|info_list| [info_list[1]]}
    strengths = []
    weaknesses = []
    sorted_data[0..4].each do |info_list|
      question = Questions.find_by_id(info_list[0])
      strengths.push(question.msg1) #strength message
    end

    weak_count = 0
    index = sorted_data.size - 1
    while weak_count < 5: #need 5 weaknesses
      break if index < 0
      info_list = sorted_data[index]
      if info_list[2] #check if possible to be weakness
        question = Questions.find_by_id(info_list[0])
        weaknesses.push(question.msg2) #weakness message
        weak_count = weak_count + 1
      end
      index = index - 1
    end

    #returns a list with [[str messages],[weak messages]]
    return [strengths, weaknesses]
  end


end



