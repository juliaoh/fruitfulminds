class PresurveysController < ApplicationController
  def new
    @all_schools = School.all.collect { |s| ["#{s.name}", s.id] }
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
      redirect_to new_presurvey_path(:presurvey => params[:presurvey], :efficacy => params[:efficacy])
    end
  end

  def edit
    @presurvey = Presurvey.find_by_id(params[:id])
    @curriculum = Curriculum.find_by_id(@presurvey.curriculum_id)
  end
  
  def update
    begin
      presurvey = Presurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
      fdata = {}
      curriculum.sections.each do |section|
        section.questions.each do |question|
          fdata[question.id.to_s] = params[question.id.to_s]
        end
      end
      presurvey.data = fdata
      presurvey.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to presurvey_path(:id => params[:id])
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurvey_path
    end
  end

  def show
    @presurvey = Presurvey.find_by_id(params[:id])
    @curriculum = Curriculum.find_by_id(@presurvey.curriculum_id)
  end
end
