class PostsurveysController < ApplicationController
  def edit
    postsurvey = Postsurvey.find_by_id(params[:id])
    if params[:failed_data]
      @postsurvey_data = {}
      params[:failed_data].each do |qid, num|
        @postsurvey_data[Integer(qid)] = num
      end
      @student_subtotal = params[:failed_subtotal]
      @absolute_total = params[:failed_absolute_total]
    else
      @postsurvey_data = postsurvey.get_data[@current_user.id]
      @student_subtotal = postsurvey.get_subtotal[@current_user.id]
      @absolute_total = postsurvey.course.total_students
    end
    @curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
    @school_name = postsurvey.course.name
  end

  def update
    begin
      postsurvey = Postsurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
      new_data = self.class.get_results_from_params(curriculum, params)
      new_subtotal = params["student_subtotal"]
      new_absolute_total = params["absolute_total_students"]
      postsurvey.data[@current_user.id] = self.class.convert_results(new_data)
      postsurvey.total[@current_user.id] = Integer(new_subtotal)
      postsurvey.course.total_students = Integer(new_absolute_total)
      postsurvey.save!
      postsurvey.course.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to postsurvey_path(:id => params[:id])
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_postsurvey_path(:failed_data => new_data, :failed_subtotal => new_subtotal, :failed_absolute_total => new_absolute_total)
    end
  end

  def show
    postsurvey = Postsurvey.find_by_id(params[:id])
    @school_name = postsurvey.course.name
    @absolute_total = postsurvey.course.total_students
    @curriculum = Curriculum.find_by_id(postsurvey.curriculum_id)
    @users = postsurvey.course.users
    @postsurvey_data = postsurvey.get_data
    @postsurvey_total = postsurvey.get_subtotal
  end

  def self.get_results_from_params(curriculum, params)
    new_data = {}
    curriculum.sections.each do |section|
      section.questions.each do |question|
        new_data[question.id] = params[question.id.to_s]
      end
    end
    return new_data
  end

  def self.convert_results(data)
    data.each do |qid, num|
      data[qid] = Integer(data[qid])
    end
    return data
  end
end
