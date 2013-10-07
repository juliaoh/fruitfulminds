class Presurveys::Part2Controller < ApplicationController
  def new
    @all_schools = School.all
    @presurvey_part2_fields = Presurvey::Part2.new(params[:presurvey_part2])
    @efficacy_fields = Efficacy.new(params[:efficacy])
  end

  def create
    if params[:admin]
      school = School.find(params[:admin][:school_id])
    else
      school = School.find(@school)
    end
    begin
      ps = @current_user.presurvey_part2s.new
      ps.school_semester_id = SchoolSemester.find(school).id
      ps.update_attributes!(params[:presurvey_part2])
      eff = Efficacy.new
      eff.part2_id = ps.id
      eff.number_students = params[:presurvey_part2][:number_students]
      eff.update_attributes!(params[:efficacy])
      flash[:notice] = "Results successfully added."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to new_presurveys_part2_path(:presurvey_part2 => params[:presurvey_part2], :efficacy => params[:efficacy])
    end
  end

  def edit
    @presurvey_part2_fields = Presurvey::Part2.find(params[:id])
    @efficacy_fields = Efficacy.find_by_part2_id(@presurvey_part2_fields.id)
  end
  
  def update
    begin
      Presurvey::Part2.find(params[:id]).update_attributes!(params[:presurvey_part2])
      Efficacy.find_by_part2_id(params[:id]).update_attributes!(:number_students => params[:presurvey_part2][:number_students])
      Efficacy.find_by_part2_id(params[:id]).update_attributes!(params[:efficacy])
      flash[:notice] = "Survey updated successfully."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurveys_part2_path(:id => params[:id], :presurvey_part2 => params[:presurvey_part2], :efficacy => params[:efficacy])
    end
  end
end
