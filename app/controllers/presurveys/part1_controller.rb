class Presurveys::Part1Controller < ApplicationController
  def new
    @all_schools = School.all
    @presurvey_part1_fields = Presurvey::Part1.new(params[:presurvey_part1])
  end

  def create
    if params[:admin]
      school = School.find(params[:admin][:school_id])
    else
      school = School.find(@school)
    end
    begin
      ps = @current_user.presurvey_part1s.new
      ps.school_semester_id = SchoolSemester.find(school).id
      ps.update_attributes!(params[:presurvey_part1])
      flash[:notice] = "Results successfully added."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to new_presurveys_part1_path(:presurvey_part1 => params[:presurvey_part1])
    end
  end

  def edit
    @presurvey_part1_fields = Presurvey::Part1.find(params[:id])
  end
  
  def update
    begin
      Presurvey::Part1.find(params[:id]).update_attributes!(params[:presurvey_part1])
      flash[:notice] = "Survey updated successfully."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurveys_part1_path(:id => params[:id], :presurvey_part1 => params[:presurvey_part1])
    end
  end
end
