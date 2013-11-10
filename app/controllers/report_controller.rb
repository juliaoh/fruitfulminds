#temporary file, will replace reports_controller.rb later

class ReportsController < ApplicationController
  def new
    #New report page should only list the classes that the ambassador is part of
    @classes = @current_user.classes

  end

  def create
    #user selects which class to generate a report for
    @class = Class.find_by_id(params[:class])
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
    @curriculum = Survey.find_by_id(@class.curriculum_id)
    #presurvey & postsurvey are hashes of
    #{user_id => {q_id => value, 'total' => # of students user is entering data for}}
    @presurvey = Presurvey.find_by_id(@class.presurvey_id).data
    @postsurvey = Postsurvey.find_by_id(@class.postsurvey_id).data

    @presurvey_total = 0
    @postsurvey_total = 0
    @presurvey.keys.each do |user_id|
      @presurvey_total += @presurvey[user_id]['total'] #adds number of students user_id is entering data for
    @postsurvey.keys.each do |user_id|
      @postsurvey_total += @presurvey[user_id]['total']

    generate_intro_text

    
  end


  def generate_intro_text
    @ambassadors = ""
    @class.users.each do |user_id|
      @ambassadors += User.find_by_id(user_id).name + ", "
    end

    @main_title = "Fruitful Minds #{@school_name} #{@school_semester} Report"
    @school_intro_title = "Fruitful Minds at #{@school_name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school_name} during #{@school_semester}" 
    @school_intro_second = "    #{@class.users.size} students from UC Berkeley #{was_were(@class.users.size)} selected as Fruitful Minds ambassadors"
    @school_intro_third = "    During each 50-minute lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
    @eval_intro_first = "Prior to the 7-week curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
   
    @efficacy = calculate_efficacy
    @eval_intro_second = "On average, students have shown a #{@efficacy}% improvement after going through seven weeks of classes." 
    @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@school_semester.presurvey_part1s[0].number_students} took the pre-curriculum survey, and #{@school_semester.postsurveys[0].number_students} students took the post-curriculum surveys."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school_name}"
    generate_weaknesses
    generate_strengths
    @ambassadorNoteTitle = "Ambassador Notes: "
    #@objectives is a hash of
    #Section name => objective description
    @objectives = {}
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      section_name = section.name
      section_objective = section.objective
      @objectives[section_name] = section.objective

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
  