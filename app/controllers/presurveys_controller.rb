class PresurveysController < ApplicationController
  def new
    @all_schools = School.all
    @presurvey_fields = Presurvey.new(params[:presurvey])
    @efficacy_fields = Efficacy.new(params[:efficacy])
  end

  def create
    if params[:admin]
      school = School.find(params[:admin][:school_id])
    else
      school = School.find(@school)
    end
    begin
      ps = @current_user.presurveys.new
      ps.school_semester_id = SchoolSemester.find(school).id
      ps.update_attributes!(:data=>params[:presurvey])
      eff = Efficacy.new
      eff.presurvey_id = ps.id
      eff.number_students = params[:presurvey][:number_students]
      eff.update_attributes!(params[:efficacy])
      flash[:notice] = "Results successfully added."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to new_presurveys_path(:presurvey => params[:presurvey], :efficacy => params[:efficacy])
    end
  end

  def edit
    @presurvey_fields = Presurvey.find(params[:id])
    @efficacy_fields = Efficacy.find_by_presurvey_id(@presurvey_fields.id)
  end
  
  def update
    begin
      Presurvey.find(params[:id]).update_attributes!(:data=>params[:presurvey])
      Efficacy.find_by_presurvey_id(params[:id]).update_attributes!(:number_students => params[:presurvey][:number_students])
      Efficacy.find_by_presurvey_id(params[:id]).update_attributes!(params[:efficacy])
      flash[:notice] = "Survey updated successfully."
      redirect_to presurvey_path(:id => params[:id])
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurveys_path(:presurvey => params[:presurvey], :efficacy => params[:efficacy])
    end
  end

  def show
    @presurvey_fields = Presurvey.find(params[:id])
  end
end
