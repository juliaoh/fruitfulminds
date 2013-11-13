class PresurveysController < ApplicationController
  def edit
    presurvey = Presurvey.find_by_id(params[:id])
    if params[:failed_data]
      @presurvey_data = {}
      params[:failed_data].each do |qid, num|
        @presurvey_data[Integer(qid)] = num
      end
    else
      @presurvey_data = presurvey.data
    end
    @curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
  end
  
  def update
    begin
      presurvey = Presurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
      new_data = get_results_from_params(curriculum, params)
      new_data.each do |qid, num|
        new_data[qid] = Integer(new_data[qid])
      end
      presurvey.data = new_data
      presurvey.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to presurvey_path(:id => params[:id])
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurvey_path(:failed_data => new_data)
    end
  end

  def show
    @presurvey = Presurvey.find_by_id(params[:id])
    @curriculum = Curriculum.find_by_id(@presurvey.curriculum_id)
  end

  def get_results_from_params(curriculum, params)
    new_data = {}
    curriculum.sections.each do |section|
      section.questions.each do |question|
        new_data[question.id] = params[question.id.to_s]
      end
    end
    return new_data
  end
end
