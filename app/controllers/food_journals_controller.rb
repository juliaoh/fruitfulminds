class FoodJournalsController < ApplicationController
  def index
  end

  def new
    @food_journal_main_fields = FoodJournal.new(params[:food_journal])
    @food_journal_week_1_fields = FoodJournal.new(params[:food_journal_week_1_fields])
    @food_journal_week_x_fields = FoodJournal.new(params[:food_journal_week_x_fields])
    @food_journal_week_8_fields = FoodJournal.new(params[:food_journal_week_8_fields])
  end

  def create
    begin
      if params[:food_journal][:student_name].empty?
        flash[:warning] = "Student Name cannot be empty."
        redirect_to new_foodjournal_path(:food_journal => params[:food_journal], :food_journal_week_1_fields => params[:food_journal_week_1_fields], :food_journal_week_x_fields => params[:food_journal_week_x_fields], :food_journal_week_8_fields => params[:food_journal_week_8_fields]) and return
      end

      if params[:food_journal_week_1_fields].values.all?{|v| v.empty?} and params[:food_journal_week_x_fields].values.all?{|v| v.empty?} and params[:food_journal_week_8_fields].values.all?{|v| v.empty?}
        flash[:warning] = "No results filled in."
        redirect_to new_foodjournal_path(:food_journal => params[:food_journal]) and return
      end

      new_food_journal_1
      new_food_journal_x
      new_food_journal_8

      flash[:notice] = "Results successfully added."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to new_foodjournal_path(:food_journal => params[:food_journal], :food_journal_week_1_fields => params[:food_journal_week_1_fields], :food_journal_week_x_fields => params[:food_journal_week_x_fields], :food_journal_week_8_fields => params[:food_journal_week_8_fields])
    end
  end
  
  def edit
    food_journal_student = FoodJournal.find(params[:id]).student_name
    food_journals = FoodJournal.find_all_by_student_name(food_journal_student)
    wn = nil
    food_journals.each do |fj|
      if fj.week_num != 1 and fj.week_num != 8
        wn = fj.week_num
      end
    end
    if wn
      @food_journal_main_fields = FoodJournal.find_by_student_name_and_week_num(food_journal_student, wn)
      @food_journal_week_x_fields = @food_journal_main_fields
    else
      @food_journal_main_fields = FoodJournal.find_by_student_name(food_journal_student)
      @food_journal_main_fields.week_num = nil
      @food_journal_week_x_fields = FoodJournal.new(params[:food_journal_week_x_fields])
    end
    @food_journal_week_1_fields = FoodJournal.find_by_student_name_and_week_num(food_journal_student, 1)
    if not @food_journal_week_1_fields
      @food_journal_week_1_fields = FoodJournal.new(params[:food_journal_week_1_fields])
    end
    @food_journal_week_8_fields = FoodJournal.find_by_student_name_and_week_num(food_journal_student, 8)
    if not @food_journal_week_8_fields
      @food_journal_week_8_fields = FoodJournal.new(params[:food_journal_week_8_fields])
    end
  end

  def update
    begin
      if params[:food_journal][:student_name].empty?
        flash[:warning] = "Student Name cannot be empty."
        redirect_to edit_foodjournal_path(:food_journal => params[:food_journal], :food_journal_week_1_fields => params[:food_journal_week_1_fields], :food_journal_week_x_fields => params[:food_journal_week_x_fields], :food_journal_week_8_fields => params[:food_journal_week_8_fields]) and return
      end
      
      food_journal_student = FoodJournal.find(params[:id]).student_name
      new_student_name = params[:food_journal][:student_name]

      if FoodJournal.find_by_student_name_and_week_num(food_journal_student, 1)
        FoodJournal.find_by_student_name_and_week_num(food_journal_student, 1).update_attributes!(params[:food_journal_week_1_fields].merge(:student_name => new_student_name))
      else
        new_food_journal_1
      end

      food_journal_x = FoodJournal.find_by_student_name(food_journal_student, :conditions => ["week_num != 1 AND week_num != 8"])
      if food_journal_x
        food_journal_x_week_num = food_journal_x.week_num
      end
      if FoodJournal.find_by_student_name_and_week_num(food_journal_student, food_journal_x_week_num)
        FoodJournal.find_by_student_name_and_week_num(food_journal_student, food_journal_x_week_num).update_attributes!(params[:food_journal_week_x_fields].merge(:student_name => new_student_name, :week_num => params[:food_journal][:week_num]))
      else
        new_food_journal_x
      end

      if FoodJournal.find_by_student_name_and_week_num(food_journal_student, 8)
        FoodJournal.find_by_student_name_and_week_num(food_journal_student, 8).update_attributes!(params[:food_journal_week_8_fields].merge(:student_name => new_student_name))
      else
        new_food_journal_8
      end
      flash[:notice] = "Results successfully updated."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to update. Incomplete or has invalid characters."
      redirect_to edit_foodjournal_path(:food_journal => params[:food_journal], :food_journal_week_1_fields => params[:food_journal_week_1_fields], :food_journal_week_x_fields => params[:food_journal_week_x_fields], :food_journal_week_8_fields => params[:food_journal_week_8_fields])
    end
  end

  protected
  def new_food_journal_1
    school, stu_name = school_and_stu_name
    if not params[:food_journal_week_1_fields].values.all?{|v| v.empty?}
      fj1 = @current_user.food_journals.new
      fj1.school_semester_id = SchoolSemester.find(school).id
      fj1.week_num = 1
      fj1.student_name = stu_name
      fj1.update_attributes!(params[:food_journal_week_1_fields])
    end
  end

  def new_food_journal_x
    school, stu_name = school_and_stu_name
    week = params[:food_journal][:week_num]
    if not params[:food_journal_week_x_fields].values.all?{|v| v.empty?}
      fjx = @current_user.food_journals.new
      fjx.school_semester_id = SchoolSemester.find(school).id
      fjx.week_num = week
      fjx.student_name = stu_name
      fjx.update_attributes!(params[:food_journal_week_x_fields])
    end
  end

  def new_food_journal_8
    school, stu_name = school_and_stu_name
    if not params[:food_journal_week_8_fields].values.all?{|v| v.empty?}
      fj8 = @current_user.food_journals.new
      fj8.school_semester_id = SchoolSemester.find(school).id
      fj8.week_num = 8
      fj8.student_name = stu_name
      fj8.update_attributes!(params[:food_journal_week_8_fields])
    end
  end
  
  def school_and_stu_name
    if params[:admin]
      school = School.find(params[:admin][:school_id])
    else
      school = School.find(@school)
    end
    stu_name = params[:food_journal][:student_name]
    return school, stu_name
  end
end
