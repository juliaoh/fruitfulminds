class PresurveysController < ApplicationController
  def edit
    presurvey = Presurvey.find_by_id(params[:id])
    if params[:failed_data]
      @presurvey_data = {}
      params[:failed_data].each do |qid, num|
        @presurvey_data[Integer(qid)] = num
      end
      @student_subtotal = params[:failed_subtotal]
      @absolute_total = params[:failed_absolute_total]
    else
      @presurvey_data = presurvey.get_data[@current_user.id]
      @student_subtotal = presurvey.get_subtotal[@current_user.id]
      @absolute_total = presurvey.course.total_students
    end
    @curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
    @school_name = presurvey.course.name
  end

  def update
    begin
      presurvey = Presurvey.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
      new_data = self.class.get_results_from_params(curriculum, params)
      new_subtotal = params["student_subtotal"]
      new_absolute_total = params["absolute_total_students"]
      presurvey.data[@current_user.id] = self.class.convert_results(new_data)
      presurvey.total[@current_user.id] = Integer(new_subtotal)
      presurvey.course.total_students = Integer(new_absolute_total)
      presurvey.save!
      presurvey.course.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to presurvey_path(:id => params[:id])
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to edit_presurvey_path(:failed_data => new_data, :failed_subtotal => new_subtotal, :failed_absolute_total => new_absolute_total)
    end
  end

  def show
    presurvey = Presurvey.find_by_id(params[:id])
    @school_name = presurvey.course.name
    @absolute_total = presurvey.course.total_students
    @curriculum = Curriculum.find_by_id(presurvey.curriculum_id)
    @users = presurvey.course.users
    @presurvey_data = presurvey.get_data
    @presurvey_total = presurvey.get_subtotal
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
