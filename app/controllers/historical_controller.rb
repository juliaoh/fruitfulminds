class HistoricalController < ApplicationController
  before_filter :admin_only
  skip_before_filter :verify_authenticity_token, :only => [:new, :create]
  include SchoolsHelper

  def new
    @schools = get_school_names
    @times = Course.all.collect { |t| ["#{t.semester}", t.id] }.uniq.sort
  end

  def index
    chosen_schools = params[:school]
    if not chosen_schools
      flash[:notice] = "Please select a school."
      redirect_to new_historical_path and return
    end
    chosen_times = params[:semester]
    if not chosen_times
      flash[:notice] = "Please select a time."
      redirect_to new_historical_path and return
    end
    chosen_results = params[:result_options]
    @show_efficacy, @show_mc = false, false
    if chosen_results
      @show_efficacy = chosen_results.include? "efficacy"
      @show_mc = chosen_results.include?  "mc"
    end
    # initialize the dictionaries of information to return
    @deltas = {}
    @efficacy_weakness, @efficacy_strength, @efficacy_competency = {}, {}, {}
    @strength, @weakness, @competency = {}, {}, {}
    @ambassador_note, @report_links = {}, {}
    @schools, @semesters = {}, {}
    @chosen_courses = Course.find(:all, :conditions => ["school_id in (?) and semester in (?)", chosen_schools, chosen_times])
    if @chosen_courses
      _extract_course_information
    else
      flash[:notice] = "No courses of selected schools and semesters found."
      redirect_to new_historical_path and return
    end
  end

  def _extract_course_information
    # extract the course information as requested
    # such as the delta, strength and weakness messages, etc
     @chosen_courses.each do |course|
      report = Report.find_by_course_id(course.id)
      if report
        @deltas[report.id] = report.delta
        @efficacy_weakness[report.id] = report.efficacy_weaknesses
        @efficacy_strength[report.id] = report.efficacy_strengths
        @efficacy_competency[report.id] = report.efficacy_competencies
        @weakness[report.id] = report.weaknesses
        @strength[report.id] = report.strengths
        @competency[report.id] = report.competencies
        @ambassador_note[report.id] = report.ambassador_message
        @report_links[report.id] = report.report_link
        school = School.find_by_id(course.school_id)
        @schools[report.id] = "#{school.name}, #{school.city}, #{school.county}"
        @semesters[report.id] = course.semester
      end
    end
  end
end
