class PostsurveysController < ApplicationController
  def edit
    postsurvey = Postsurvey.find_by_id(params[:id])
    @curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
    if not params[:failed_data]
      @postsurvey_data = postsurvey.data
    else
      @postsurvey_data = {}
      params[:failed_data].each do |qid, num|
        @postsurvey_data[Integer(qid)] = num
      end
    end
  end
  
  def update
    begin
      postsurvey = Postsurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
      new_data = PresurveysController.get_results_from_params(curriculum, params)
      new_data.each do |qid, num|
        new_data[qid] = Integer(new_data[qid])
      end
      postsurvey.data[@current_user.id] = PresurveysController.convert_results(new_data)
      postsurvey.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to postsurvey_path(:id => params[:id])
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_postsurvey_path(:failed_data => new_data)
    end
  end

  def show
    postsurvey = Postsurvey.find_by_id(params[:id])
    @postsurvey_data = postsurvey.data
    @curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
    @users = postsurvey.users
  end
end
