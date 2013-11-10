#temporary file, will replace reports_controller.rb later

class ReportsController < ApplicationController
  def new
    #New report page should only list the classes that the ambassador is part of
    @classes = @current_user.classes

  end

  def create
    #user selects which class to generate a report for
    @class = Class.find_by_id(params[:class])

    #A class is uniquely defined by 
    #1) School ID (number)
    #2) Semester (string)
    #3) Curriculum ID (number), curriculum corresponds to survey
    #Example: 1, 'Fall 2013', 1 could correspond to Ascend Elementary, 'Fall 2013', 5th Grade Curriculum

    @school = School.find_by_id(@class.school_id)
    @school_name = @school.name
    @school_semester = @class.school_semester
    @curriculum = Survey.find_by_id(@class.curriculum_id)

    


  end

