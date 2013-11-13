class PostsurveysController < ApplicationController
  def edit
    postsurvey = Postsurvey.find_by_id(params[:id])
    if params[:failed_data]
      @postsurvey_data = {}
      params[:failed_data].each do |qid, num|
        @postsurvey_data[Integer(qid)] = num
      end
    else
      @postsurvey_data = postsurvey.data
    end
    @curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
  end
  
  def update
    begin
      postsurvey = Postsurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
      new_data = {}
      curriculum.sections.each do |section|
        section.questions.each do |question|
          new_data[question.id] = params[question.id.to_s]
        end
      end
      new_data.each do |qid, num|
        new_data[qid] = Integer(new_data[qid])
      end
      postsurvey.data = new_data
      postsurvey.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to postsurvey_path(:id => params[:id])
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_postsurvey_path(:failed_data => new_data)
    end
  end

  def show
    @postsurvey = Postsurvey.find_by_id(params[:id])
    @curriculum = Curriculum.find_by_id(@postsurvey.curriculum_id)
  end
end
