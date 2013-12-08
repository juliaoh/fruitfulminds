class ReportsController < ApplicationController
  include ReportsHelper
  def new
    #New report page should only list the classes that the ambassador is part of
    @courses = @current_user.courses
  end

  def create
    #user selects which class to generate a report for
    @course = Course.find_by_id(params[:course])
    if @course.nil?
      flash[:warning] = "Course not found"
      redirect_to "/reports/new" and return
    elsif @course.users.empty?
      flash[:warning] = "Course has no data or ambassador assigned"
      redirect_to "/reports/new" and return
    end
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
    # initialize_fields_in_report and warn_incomplete_report in ReportHelper
    initialize_fields_in_report
    if warn_incomplete_report
      return
    end
    calc_subtotals
    generate_intro_text
    generate_summary
    generate_warnings
  end

  def calc_subtotals
    @presurvey_total = 0
    @postsurvey_total = 0
    @presurvey.total.values.each do |subtotal|
      @presurvey_total += subtotal
    end
    @postsurvey.total.values.each do |subtotal|
      @postsurvey_total += subtotal
    end
  end

  def generate_intro_text
    # nothing below is used?
    #@ambassadors = ""
    #@course.users.each do |user_id|
    #  @ambassadors += User.find_by_id(user_id).name + ", "
    #end

    @college = User.find_by_id(@course.users[0]).college
    @college = @college.name

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

    assign_titles
    @improvement_intro = "#{@presurvey_total} students took the pre-curriculum survey and #{@postsurvey_total} students took the post-curriculum survey. These were not necessarily the same students."

  end

  def assign_titles
    @main_title = "Fruitful Minds #{@school_name} #{@school_semester} Report"
    @school_intro_title = "Fruitful Minds at #{@school_name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school_name} during #{@school_semester}"
    @school_intro_second = "    #{@course.users.size} students from #{@college} #{was_were(@course.users.size)} selected as Fruitful Minds ambassadors"
    @school_intro_third = "    During each lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school_name}"
    assign_efficacy_titles

    @ambassadorNoteTitle = "Ambassador Notes: "

  end

  def assign_efficacy_titles
    efficacy_data = generate_data('Efficacy')
    objective_data = generate_data('Multiple Choice')
    if efficacy_data.nil? or objective_data.nil?
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    elsif efficacy_data[0].keys.length != @questions['Efficacy'].length or efficacy_data[1].keys.length != @questions['Efficacy'].length
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    elsif objective_data[0].keys.length != @questions['Multiple Choice'].length or objective_data[1].keys.length != @questions['Multiple Choice'].length
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    end
    efficacy_stats_handler(efficacy_data)
    objective_stats_handler(objective_data)
  end

  def efficacy_stats_handler(efficacy_data)
    efficacy_stats = generate_strengths(efficacy_data)
    generate_efficacy_graph(efficacy_data)
    if not efficacy_stats.nil?
      @efficacy_str = efficacy_stats[0] #hash {q_name => msg}
      if @efficacy_str.keys.length == 0
        @efficacy_str['N/A'] = 'Students show no significant increase in agreement'
      end
      @efficacy_weak = efficacy_stats[1]
      @efficacy_comp = efficacy_stats[2]
      if @efficacy_comp.keys.length == 0
        @efficacy_comp['N/A'] = 'Students did not show competency in any areas of Fruitful Minds teaching prior to the lessons.'
      end
    end
  end

  def objective_stats_handler(objective_data)
    generate_objective_graph(objective_data)
    objective_stats = generate_strengths(objective_data)
    if not objective_stats.nil?
      @objective_str = objective_stats[0] #hash {q_name => msg}
      if @objective_str.keys.length == 0
        @objective_str['N/A'] = 'Students show no strengths'
      end
      @objective_weak = objective_stats[1]
      @objective_comp = objective_stats[2]
      if @objective_comp.keys.length == 0
        @objective_comp['N/A'] = 'Students did not show competency in any areas of Fruitful Minds teaching prior to the lessons.'
      end
      @eval_intro_first = "Prior to the curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
      @eval_intro_second = "On average, students have shown a #{@improvement}% improvement after going through seven weeks of classes."
      @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@presurvey_total} students took the pre-curriculum survey, and #{@postsurvey_total} students took the post-curriculum surveys."
    end
  end

  def generate_pdf
    @course = Course.find_by_id(params[:course][:id])
    session[:course] = @course.id
    if not params[:amb_note].blank?
      #make sure ambassador writes some Notes
      session[:amb_note] = params[:amb_note]
      save_report
      redirect_to "/reports/#{@file_name}"
      return
    else
      flash[:warning] = "Could not generate the PDF report: Please enter ambassador notes"
      redirect_to new_report_path
    end
  end

  def show
    @report_name = params[:id].chomp("_report")
    course_id = @report_name.match(/\d+$/)[0]
    @school_name = @report_name.chomp("_#{course_id}").gsub! /_/, " "
    #course_id = session[:course]
    @course = Course.find_by_id(course_id)
    report = Report.find_by_course_id(course_id)
    @report_note = session[:amb_note]
    if @report_note.nil?
      if not report.nil?
        @report_note = report.ambassador_message
      else
        @report_note = " "
      end
    end

    generate_report
  end


  def save_report
    generate_report
    @report_note = session[:amb_note]
    file = @school_name.gsub! /\s+/, '_'
    file = file.downcase
    time = @school_semester.gsub! /\s+/, '_'
    time = time.downcase
    @file_name = "#{file}_#{time}_#{@course.id}_report.pdf"

    report = Report.find_by_course_id(@course.id)
    if report.nil?
      Report.create!({:delta => @improvement, :efficacy_strengths=> @efficacy_str, :efficacy_weaknesses=>@efficacy_weak, :efficacy_competencies=>@efficacy_comp, :strengths=>@objective_str, :weaknesses=>@objective_weak, :competencies=>@objective_comp, :ambassador_message=>@report_note, :report_link=>"/reports/#{@file_name}"}, :course_id=>@course.id)
    else
      report.delta = @improvement
      report.efficacy_strengths = @efficacy_str
      report.efficacy_weaknesses = @efficacy_weak
      report.efficacy_competencies = @efficacy_comp
      report.strengths = @objective_str
      report.weaknesses = @objective_weak
      report.competencies = @objective_comp
      report.ambassador_message = @report_note
      report.report_link = "/reports/#{@file_name}"
      report.course_id = @course.id
      report.save!
    end
    # @file_name = "#{file}_report.pdf"
  end


  def format_objective_data(data_list)
    #data_list is [{presurvey},{postsurvey}]
    #pre/postsurvey are {q_id => value}
    #this function will sum up the q_values for each section
    #also returns combined_data which sums up q_values for all pre vs post
    # returns [data, combined_data]
    # format of data and combined data is [[presurvey],[postsurvey]]
    # where pre/post are just a list of values e.g. data = [[2,4,5],[5,8,9]]

    data = []
    combined_data = []

    @max = 0
    @combined_max = 0
    pre_data = []
    post_data = []
    pre_combined = [0]
    post_combined = [0]
    questions = ""
    data_list[0].keys.each do |q_id|
      questions += " " + Question.find_by_id(q_id).name + " qid: " + q_id.to_s
    end
    values = ""
    data_list[0].values.each do |v|
      values += " " + v.to_s
    end

    total_question_count = format_objective_data_helper(data_list, pre_combined, post_combined, pre_data, post_data)
    pre_combined[0] /= total_question_count
    post_combined[0] /= total_question_count
    @max = [pre_data.compact.max, post_data.compact.max].max
    @combined_max = [pre_combined[0], post_combined[0]].max
    data = [pre_data, post_data]
    combined_data = [pre_combined, post_combined]
    return data, combined_data
  end


  def format_objective_data_helper(data_list, pre_combined, post_combined, pre_data, post_data)
    total_question_count = 0
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != 'Multiple Choice'
      section_pre_total = 0
      section_post_total = 0
      section_question_count = 0
      section.questions.each do |question|
        q_id = question.id
        if data_list[0][q_id].nil? or data_list[1][q_id].nil?
          question = Question.find_by_id(q_id)
          flash[:warning] = "Unexpected error with data (Check if data is incomplete)"
          redirect_to "/reports/new" and return
        end
        section_pre_total += data_list[0][q_id]
        section_post_total += data_list[1][q_id]
        pre_combined[0] += data_list[0][q_id]
        post_combined[0] += data_list[1][q_id]
        section_question_count += 1
        total_question_count += 1
      end
      pre_data.push(section_pre_total/section_question_count)
      post_data.push(section_post_total/section_question_count)
    end
    return total_question_count
  end

  def generate_objective_graph(data_list)
    #data_list is a list of hashes [{presurvey},{postsurvey}]
    #hashes are {q_id => value}
    #graph should be
    #y-axis: % value
    #x-axis SECTIONS (not q_id/questions)



    if data_list.nil?
      return
    end
    axes = []
    labels = ""
    graph_width = 100
    @objectives.keys.each do |section_name|
      if section_name.length > 12
        section_name = section_name[0..11] + "..."
      end
      axes.push(section_name)
      labels += section_name+"|"
      graph_width += 83
    end
    labels.chomp('|')

    data = []
    combined_data = []
    data, combined_data = format_objective_data(data_list)
    if data.nil? or combined_data.nil?
      return
    end
    @improvement = combined_data[1] - combined_data[0]
    if not @improvement[0].nil?
      @improvement = @improvement[0].round(2)
    else
      @improvement[0] = 0
    end
    prescore = combined_data[0]
    postscore = combined_data[1]
    size = graph_width.to_s + 'x300'
    @nutrition_chart = Gchart.bar(:size => size,
                                :title => "Survey Score in Nutrition Topics(%)",
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
                              :legend => ['Pre-curriculum Results (' + prescore[0].round(2).to_s + '%)', 'Post-curriculum Results (' + postscore[0].round(2).to_s + '%)'],
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
    if data_list.nil?
      return
    end
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
    combined_data = []
    graph_height = 60
    data_list.each do |survey_hash| #formats data to be [[presurvey_values],[postsurvey_values]]
      combined = 0
      survey_list = []
      graph_height = 60
      survey_hash.values.each do |value|
        survey_list.push(value)
        combined += value
        graph_height += 25
      end
      combined_data.push(combined)
      data.push(survey_list)
      if survey_list.size > 0 and survey_list.compact.max > @max
        @max = survey_list.compact.max
      end
    end
    @efficacy_improvement = combined_data[1] - combined_data[0]
    if @efficacy_improvement.nil?
      @efficacy_improvement = 0
    end
    size = '500x' + graph_height.to_s
    @efficacy_chart = Gchart.bar(:size => size,
                              :title => "Efficacy Survey Results - Agreement(%)",
                              :legend => ['Pre', 'Post'],
                              :bar_colors => '990000,3399CC',
                              :data => data,
                              :bar_width_and_spacing => '10,0,5',
                              :axis_with_labels => 'y,x',
                              :axis_labels => [labels],
                              :stacked => false,
                              :axis_range => [nil, [0,@max,10]],
                              :orientation => 'horizontal'
                              )


  end

  def generate_data(type)
    #type should be either 'Efficacy' or 'Multiple Choice'
    #returns [presurvey_data, postsurvey_data]
    #where pre&postsurvey_data are hashes {q_id, value}
    #and value is % correct answers entered to total number of students

    presurvey_data = {}
    postsurvey_data = {}
    #presurvey.data & postsurvey.data are hashes of
    #{user => {q_id => value}}
    @type = type
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

    @questions[@type] = []
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != @type
      section.questions.each do |q_id|
        question = Question.find_by_id(q_id)
        @questions[@type].push(question)
      end
    end

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
      presurvey_data = calc_values(user_pre_data, presurvey_data, @presurvey_total)
      postsurvey_data = calc_values(user_post_data, postsurvey_data, @postsurvey_total)
    end

    data = [presurvey_data, postsurvey_data]

    return data
  end



  def generate_strengths(data_list)
    strengths = {}
    weaknesses = {}
    comps = {}
    if data_list.nil?
      flash[:warning] = "Not enough data"
      return
    end
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
      possible_weakness = (((pre_value >= 80) and (post_value < 80)) or pre_value < 80)
      if (pre_value >= 80 and post_value >= 80)
        question = Question.find_by_id(q_id)
        comps[question.name] = question.msg
      end
      info_list = [q_id, delta, possible_weakness]
      data.push(info_list)
    end

    #info_list is [q_id, delta, possible_weakness]
    sorted_data = data.sort_by {|info_list| [info_list[1]]}
    sorted_data[0..4].each do |info_list|
      question = Question.find_by_id(info_list[0])
      if info_list[1] > 0 #infolist[1]  is the delta
        strengths[question.name] = question.msg
      end
    end

    weak_count = 0
    index = sorted_data.size - 1
    while weak_count < 5 do #need 5 weaknesses
      break if index < 0
      info_list = sorted_data[index]
      if info_list[2] #check if possible to be weakness
        question = Question.find_by_id(info_list[0])
        weaknesses[question.name] = question.msg #message
        weak_count = weak_count + 1
      end
      index = index - 1
    end

    #returns a list of hashes [{q_name => str message},{q_name => weak messages}]
    #q_name should be something like "Section 6 Question 4"

    return [strengths, weaknesses, comps]
  end

  def generate_warnings()
    @presurvey_subtotal /= 2
    @postsurvey_subtotal /= 2
    if @presurvey_subtotal > @postsurvey_subtotal
      @warnings.push("WARNING: Potentially skewed data due to less students taking postsurvey than students taking presurvey")
    elsif @presurvey_subtotal < @postsurvey_subtotal
      @warnings.push("WARNING: Potentially skewed data due to more students taking postsurvey than students taking presurvey")
    end

    if not @presurvey_subtotal == @course_total
      @warnings.push("WARNING: Expected #{@course_total} students for the course, but there are #{@presurvey_subtotal} entries recorded for presurvey results so far.")
    end

    if not @postsurvey_subtotal == @course_total
      @warnings.push("WARNING: Expected #{@course_total} students for the course, but there are #{@postsurvey_subtotal} entries recorded for postsurvey results so far.")
    end

    if @warnings.length > 0
      @warning_flag = true
    end

  end

  def generate_summary()
    @summary_messages = []
    if @efficacy_improvement.nil?
      return
    end
    if @efficacy_improvement > 50
      @summary_messages.push("Students showed great increases in confidence that they could perform healthy behaviors.")
    elsif @efficacy_improvement > 0
      @summary_messages.push("Students trended towards increasing confidence that they could perform healthy behaviors.")
    end

  end


end
