class HistoricalController < ApplicationController
  before_filter :admin_only
  include SchoolsHelper

  def new
    @schools = _get_school_names
    @times = Course.all.collect { |t| ["#{t.semester}", t.id] }.uniq.sort
  end

  def _get_school_names
    # returns all the school names in the database in a list

  end

  def create
    chosen_schools = params[:checked_schools]
    if not chosen_schools
      flash[:notice] = "Please select a school."
      redirect_to new_historical_path and return
    chosen_times = params[:checked_times]
    if not chosen_times
      flash[:notice] = "Please select a time."
      redirect_to new_historical_path and return
    # initialize the dictionaries of information to return
    @deltas = {}
    @efficacy_weakness, @efficacy_strength, @efficacy_competency = {}, {}, {}
    @strength, @weakness, @competency = {}, {}, {}
    @chosen_courses = Course.find(:all, :conditions => ["school in (?) and semester in (?)", chosen_schools.keys, chosen_times.keys])
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
      @deltas[report.id] = report.delta
      @efficacy_weakness[report.id] = report.efficacy_weakness
      @efficacy_strength[report.id] = report.efficacy_strength
      @efficacy_competency[report.id] = report.efficacy_competency
      @efficacy_weakness[report.id] = report.efficacy_weakness
      @efficacy_weakness[report.id] = report.efficacy_weakness
      @efficacy_weakness[report.id] = report.efficacy_weakness
      @efficacy_weakness[report.id] = report.efficacy_weakness

  end
end
