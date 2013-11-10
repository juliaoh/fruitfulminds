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

    @school = School.find_by_id(@class.school_id)
    @school_name = @school.name
    @school_semester = @class.school_semester
    @curriculum = Survey.find_by_id(@class.curriculum_id)

    #A class has 
    #a list of its ambassadors (list of user ids)
    #presurvey data (id)
    #postsurvey data (id)
    #total_students (int)

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
    generate_strengths
    generate_weaknesses

    #@objectives is a hash of
    #Section name => objective description
    @objectives = {}
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      section_name = section.name
      section_objective = section.objective
      @objectives[section_name] = section.objective

    #todo: fix this line  
    @improvement_intro = "#{@ps_part1.number_students} students took the pre-efficacy survey part 1, #{@ps_part2.number_students} students took the pre-efficacy survey part 2 and #{@ps.number_students} students took the post-efficacy survey. These were not necessarily the same students. However, on average, students showed significant increases in their agreement that they could"
  end



