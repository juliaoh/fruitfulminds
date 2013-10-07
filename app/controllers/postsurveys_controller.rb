class PostsurveysController < ApplicationController
  def new
    @all_schools = School.all
    @postsurvey_fields = Postsurvey.new(params[:postsurvey])
    @efficacy_fields = Efficacy.new(params[:efficacy])
  end

  def create
    if params[:admin]
      school = School.find(params[:admin][:school_id])
    else
      school = School.find(@school)
    end
    begin
      ps = @current_user.postsurveys.new
      ps.school_semester_id = SchoolSemester.find(school).id
      ps.update_attributes!(params[:postsurvey])
      eff = Efficacy.new
      eff.postsurvey_id = ps.id
      eff.number_students = params[:postsurvey][:number_students]
      eff.update_attributes!(params[:efficacy])
      flash[:notice] = "Results successfully added."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to new_postsurvey_path(:postsurvey => params[:postsurvey], :efficacy => params[:efficacy])
    end
  end

  def edit
    @postsurvey_fields = Postsurvey.find(params[:id])
    @efficacy_fields = Efficacy.find_by_postsurvey_id(@postsurvey_fields.id)
  end
  
  def update
    begin
      Postsurvey.find(params[:id]).update_attributes!(params[:postsurvey])
      Efficacy.find_by_postsurvey_id(params[:id]).update_attributes!(:number_students => params[:postsurvey][:number_students])
      Efficacy.find_by_postsurvey_id(params[:id]).update_attributes!(params[:efficacy])
      flash[:notice] = "Survey updated successfully."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_postsurvey_path(:id => params[:id], :postsurvey => params[:postsurvey])
    end
  end
end
