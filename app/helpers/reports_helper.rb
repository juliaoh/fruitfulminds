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

end
