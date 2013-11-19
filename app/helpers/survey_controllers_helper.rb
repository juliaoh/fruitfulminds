module SurveyControllersHelper
  def edit
    if params[:failed_data]
      setup_failed_data(params)
    else
      setup_data(params)
    end
  end

  def update
    begin
      save_results(params)
      flash[:notice] = "Survey updated successfully."
      redirect_to :action=>"show"
    rescue ArgumentError
      flash[:warning] = "Results failed to add. Incomplete or has invalid characters."
      redirect_to :action=>"edit", :failed_data => params[:new_data]
    end
  end

  def show
    setup_data(params)
  end


  protected


  def setup_data(params)
    model = controller_name.classify.constantize
    survey = model.includes({:course=> [:school, :users]}, :curriculum).find_by_id(params[:id])
    course = survey.course
    @school_name = course.name
    @absolute_total = course.total_students
    @curriculum = survey.curriculum
    @users = course.users
    @survey_data = survey.get_data
    @survey_total = survey.get_subtotal
  end

  def setup_failed_data(params)
    model = controller_name.classify.constantize
    survey = model.includes({:course=> [:school, :users]}, :curriculum).find_by_id(params[:id])
    course = survey.course
    @absolute_total = params[:failed_data].delete("absolute_total_students")
    @survey_total = {}
    @survey_data = {}
    params[:failed_data].each do |userid, questions|
      uid = Integer(userid)
      @survey_total[uid] = questions.delete("student_subtotal")
      @survey_data[uid] = {}
      questions.each do |qid, num|
        @survey_data[uid][Integer(qid)] = num
      end
    end
    @school_name = course.name
    @curriculum = survey.curriculum
    @users = course.users
  end

  def save_results(params)
    model = controller_name.classify.constantize
    survey = model.includes({:course => [:users]}, :curriculum).find_by_id(params[:id])
    curriculum = survey.curriculum
    course = survey.course
    users = course.users
    new_data = Marshal.load(Marshal.dump(params[:new_data]))
    course.total_students = Integer(new_data.delete("absolute_total_students"))
    if not @current_user.admin?
      users.select! { |user| user.id == @current_user.id }
    end
    users.each do |user|
      survey.total[user.id] = Integer(new_data["#{user.id}"].delete("student_subtotal"))
      new_data["#{user.id}"].each do |qid, num|
        survey.data[user.id][Integer(qid)] = Integer(num)
      end
    end
    survey.save!
    course.save!
  end
end
