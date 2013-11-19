module SurveyControllersHelper
  def edit
    model = controller_name.classify.constantize
    survey = model.find_by_id(params[:id])
    if params[:failed_data]
      @survey_data = {}
      params[:failed_data].each do |qid, num|
        @survey_data[Integer(qid)] = num
      end
      @student_subtotal = params[:failed_subtotal]
      @absolute_total = params[:failed_absolute_total]
    else
      @survey_data = survey.get_data[@current_user.id]
      @student_subtotal = survey.get_subtotal[@current_user.id]
      @absolute_total = survey.course.total_students
    end
    @curriculum = Curriculum.find_by_id(survey.curriculum_id)
    @school_name = survey.course.name
  end

  def update
    begin
      model = controller_name.classify.constantize
      survey = model.find_by_id(params[:id])
      curriculum = Curriculum.find_by_id(survey.curriculum_id)
      new_data = get_results_from_params(curriculum, params)
      new_subtotal = params["student_subtotal"]
      new_absolute_total = params["absolute_total_students"]
      survey.data[@current_user.id] = convert_results(new_data)
      survey.total[@current_user.id] = Integer(new_subtotal)
      survey.course.total_students = Integer(new_absolute_total)
      survey.save!
      survey.course.save!
      flash[:notice] = "Survey updated successfully."
      redirect_to :action=>"show"
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to :action=>"edit", :failed_data => new_data, :failed_subtotal => new_subtotal, :failed_absolute_total => new_absolute_total
    end
  end

  def show
    model = controller_name.classify.constantize
    survey = model.find_by_id(params[:id])
    @school_name = survey.course.name
    @absolute_total = survey.course.total_students
    @curriculum = Curriculum.find_by_id(survey.curriculum_id)
    @users = survey.course.users
    @survey_data = survey.get_data
    @survey_total = survey.get_subtotal
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

  def convert_results(data)
    data.each do |qid, num|
      data[qid] = Integer(data[qid])
    end
    return data
  end
end
