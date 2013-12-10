class ReportsController < ApplicationController
  include ReportsHelper
  include ReportsGraphHelper
  include ReportsAssignTitlesHelper
  include ActiveCoursesHelper
  def new
    #New report page should only list the classes that the ambassador is part of
    #NOT SORTED YET
    get_active_inactive(@current_user)
    #@courses = @active_courses
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
    file = @school_name.gsub /\s+/, '_'
    file = file.downcase
    time = @school_semester.gsub /\s+/, '_'
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

    #get_all_questions_of_type is defined in ReportsHelper
    get_all_questions_of_type(@type)

    #extract_data_list is defined in ReportsHelper
    data = extract_data_list(presurvey_data, postsurvey_data)
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

    #populate_data is in ReportsHelper
    populate_data(presurvey_data, postsurvey_data, data, comps)

    #info_list is [q_id, delta, possible_weakness]
    #sorts in descending order
    sorted_data = data.sort_by {|info_list| [info_list[1]]}.reverse

    #populate_strengths is in ReportsHelper
    populate_strengths(sorted_data, strengths)

    #populate_weaknesses is in ReportsHelper
    populate_weaknesses(sorted_data, weaknesses, strengths)

    #returns a list of hashes [{q_name => str message},{q_name => weak messages}
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
