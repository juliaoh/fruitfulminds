#temporary file, will replace reports_controller.rb later
#                    __ __
#            |    |    |
#            |____|    |
#            |    |    |
#            |    |  __|__
#
#some things that I haven't done (doesn't include everything):
#calculate size of graph based on # of sections in generate_objective_graph
#
#Done but is kind of complex:
#add efficacy graph
#calculate_improvement - calculates overall % improvement for MC/objective sections
#add overall improvement graph (for objective/mc)

class ReportsController < ApplicationController
  def new
    #New report page should only list the classes that the ambassador is part of
    @courses = @current_user.courses

  end

  def create
    #user selects which class to generate a report for
    @course = Course.find_by_id(params[:course])
    #@report = Report.create!(:course_id => @course.id)
    generate_report
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

  def generate_report
    if (defined?(@course)).nil?
      flash[:warning] = "@course is not defined"
      return
    end

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
    @school = School.find_by_id(@course.school_id)
    @school_name = @school.name
    @school_semester = @course.semester
    @main_semester_title = @school_semester + " Report"
    @static_contents = StaticContent.first
    @curriculum = Curriculum.find_by_id(@course.curriculum_id)
    #presurvey.total & postsurvey.total are hashes of
    #{user_id => {'total' => # of students user is entering data for}}
    @presurvey = Presurvey.find_by_id(@course.presurvey_id)
    @postsurvey = Postsurvey.find_by_id(@course.postsurvey_id)
    if @presurvey.nil? || @postsurvey.nil?
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    end
    calc_subtotals
    generate_intro_text
    

  end

  def calc_subtotals
    @presurvey_total = 0
    @postsurvey_total = 0
    @presurvey.total.values.each do |subtotal|
      @presurvey_total += subtotal #adds number of students user_id is entering data for
    end

    @postsurvey.total.values.each do |subtotal|
      @postsurvey_total += subtotal
    end

  end

  def generate_intro_text
    @ambassadors = ""
    @course.users.each do |user_id|
      @ambassadors += User.find_by_id(user_id).name + ", "
    end

    @college = User.find_by_id(@course.users[0]).college
    @college = @college.name
    assign_titles
    assign_efficacy_titles
    
    #@objectives is a hash of
    #Section name => objective description
    @objectives = {}
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      section_name = section.name
      section_objective = section.objective
      if section.stype != 'Efficacy'
        @objectives[section_name] = section.objective
      end
    end

    @objectivesTable = @objectives.map do |section_name, objective|
      [
      section_name, objective
      ]
    end

    @improvement_intro = "#{@presurvey_total} students took the pre-curriculum survey and #{@postsurvey_total} students took the post-curriculum survey. These were not necessarily the same students. However, on average, students showed significant increases in their agreement that they could"
  
  end

  def assign_titles
    @main_title = "Fruitful Minds #{@school_name} #{@school_semester} Report"
    @school_intro_title = "Fruitful Minds at #{@school_name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school_name} during #{@school_semester}" 
    @school_intro_second = "    #{@course.users.size} students from #{@college} #{was_were(@course.users.size)} selected as Fruitful Minds ambassadors"
    @school_intro_third = "    During each 50-minute lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school_name}"
    assign_efficacy_titles

    @ambassadorNoteTitle = "Ambassador Notes: "

  end

  def assign_efficacy_titles
    efficacy_data = generate_data('Efficacy')
    efficacy_str_weak = generate_strengths(efficacy_data)
    generate_efficacy_graph(efficacy_data)
    @efficacy_str = efficacy_str_weak[0] #hash {q_name => msg}
    @efficacy_weak = efficacy_str_weak[1]
    objective_data = generate_data('Multiple Choice')
    generate_objective_graph(objective_data)
    objective_str_weak = generate_strengths(objective_data)
    @objective_str = objective_str_weak[0]
    @objective_weak = objective_str_weak[1]
    puts "objective_str"
    puts @objective_str_weak
    @eval_intro_first = "Prior to the 7-week curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
    @eval_intro_second = "On average, students have shown a #{@efficacy}% improvement after going through seven weeks of classes." 
    @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@presurvey_total} took the pre-curriculum survey, and #{@postsurvey_total} students took the post-curriculum surveys."
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
    generate_report
  end


  def format_objective_data(data_list)
    data = []
    combined_data = []
    @max = 0
    @combined_max = 0
    data_list.each do |survey_hash| #formats data to be [[presurvey_values],[postsurvey_values]]
      survey_list = []
      combined_list = [0]
      survey_hash.values.each do |value|
        survey_list.push(value)
        combined_list[0] += value
      end
      data.push(survey_list)
      combined_data.push(combined_list)
      if survey_list.compact.max > @max
        @max = survey_list.compact.max
      end
      if combined_list.compact.max > @combined_max
        @combined_max = combined_list.compact.max
      end
    end
    return data, combined_data

  end

  def generate_objective_graph(data_list)
    #data_list is a list of hashes [{presurvey},{postsurvey}]
    #hashes are {q_id => value}

    axes = []
    labels = ""
    @objectives.keys.each do |section_name|
      axes.push(section_name)
      labels += section_name+"|"
    end
    labels.chomp('|')

    data = []
    combined_data = []
    data, combined_data = format_objective_data(data_list)
    @improvement = combined_data[1] - combined_data[0]

    @nutrition_chart = Gchart.bar(:size => '1000x300', 
                                :title => "Average Survey Score in Six Nutrition Topics",
                                :legend => ['Pre', 'Post'],
                                :bar_colors => '3399CC,99CCFF',
                                :data => data,
                                :bar_width_and_spacing => '30,0,23',
                                :axis_with_labels => 'x,y',
                                :axis_labels => [labels],
                                :stacked => false,
                                :axis_range => [nil, [0,@max,10]]
                                )

    @combined_chart = Gchart.bar(:size => '1000x300', 
                              :title => "Overall Combined Scores(%)",
                              :legend => ['Pre-curriculum Results', 'Post-curriculum Results'],
                              :bar_colors => 'FF3333,990000',
                              :data => combined_data,
                              :bar_width_and_spacing => '50,25,25',
                              :axis_with_labels => 'y',
                              :stacked => false,
                              :axis_range => [[0,@combined_max,10]]
                            )      


  end

  def generate_efficacy_graph(data_list)
    #data_list is a list of hashes [{presurvey},{postsurvey}]
    #hashes are {q_id => value}
    axes = []
    labels = ""
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != 'Efficacy'
      section.questions.each do |q_id|
        question = Question.find_by_id(q_id)
        labels += question.name + "|"
        axes.push(question.name)
      end
    end
    labels.chomp "|"

    data = []
    @max = 0
    data_list.each do |survey_hash| #formats data to be [[presurvey_values],[postsurvey_values]]
      survey_list = []
      survey_hash.values.each do |value|
        survey_list.push(value)
      end
      data.push(survey_list)
      if survey_list.size > 0 and survey_list.compact.max > @max
        @max = survey_list.compact.max
      else
        puts data_list
      end
    end

    @efficacy_chart = Gchart.bar(:size => '500x400', 
                              :title => "Efficacy Survey Results - Agreement(%)",
                              :legend => ['Pre', 'Post'],
                              :bar_colors => '990000,3399CC',
                              :data => data,
                              :bar_width_and_spacing => '13,0,10',
                              :axis_with_labels => 'y,x',
                              :axis_labels => [labels],
                              :stacked => false,
                              :axis_range => [nil, [0,@max,10]],
                              :orientation => 'horizontal'
                              )


  end

  def generate_data(type)
    #type should be either 'Efficacy' or 'Multiple Choice'
    presurvey_data = {}
    postsurvey_data = {}
    #presurvey.data & postsurvey.data are hashes of
    #{user_id => {q_id => value}} 

    def calc_values(data, data_hash)
      #helper function
      return data_hash if data.nil?
      data.keys.each do |q_id|
        question = Question.find_by_id(q_id)
        next if question.qtype != type #skips if not type: 'Efficacy' or 'Multiple Choice'

        #value is (ratio of correct answers entered to total number of students) * 100
        value = (data[q_id]/@course_total.to_f) * 100
        if data.include?(q_id)
          data_hash[q_id] += value
        else
          data_hash[q_id] = value
        end
      end
      return data_hash
    end

    @course.users.each do |user_id|
      user_pre_data = @presurvey.data[user_id]
      user_post_data = @postsurvey.data[user_id]

      #following code works because of invariant:
      #pre&post surveys have the exact same questions
      presurvey_data = calc_values(user_pre_data, presurvey_data)
      postsurvey_data = calc_values(user_post_data, postsurvey_data)
    end
    #pre&postsurvey_data are hashes {q_id, value}
    data = [presurvey_data, postsurvey_data]
    return data
  end



  def generate_strengths(data_list)
    #method can be used for either efficacy or MC questions
    #data_list is [presurvey_data, postsurvey_data], use generate_data to get this
    #pre/postsurvey_data is {q_id => percent value}
    presurvey_data = data_list[0]
    postsurvey_data = data_list[1]
    data = []
    
    presurvey_data.keys.each do |q_id|
      #q_id is same for both presurvey & postsurvey questions
      pre_value = presurvey_data[q_id]
      post_value = postsurvey_data[q_id]
      delta = post_value - pre_value
      #not considered a weakness if starting value is 90%
      possible_weakness = ((pre_value < 90) and (delta > 0))
      info_list = [q_id, delta, possible_weakness]
      data.push(info_list)
    end

    #info_list is [q_id, delta, possible_weakness]
    sorted_data = data.sort_by {|info_list| [info_list[1]]}
    strengths = {}
    weaknesses = {}
    sorted_data[0..4].each do |info_list|
      question = Question.find_by_id(info_list[0])
      strengths[question.name] = question.msg1 #strength message
    end

    weak_count = 0
    index = sorted_data.size - 1
    while weak_count < 5 do #need 5 weaknesses
      break if index < 0
      info_list = sorted_data[index]
      if info_list[2] #check if possible to be weakness
        question = Question.find_by_id(info_list[0])
        weaknesses[question.name] = question.msg2 #weakness message
        weak_count = weak_count + 1
      end
      index = index - 1
    end

    #returns a list of hashes [{q_name => str message},{q_name => weak messages}]
    #q_name should be something like "Section 6 Question 4"
    return [strengths, weaknesses]
  end


end
