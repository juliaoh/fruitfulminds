module CoursesHelper

  def find_course_by_school_id_and_semester_and_curriculum_id_and_identifier (user, params)
    Course.find_by_school_id_and_semester_and_curriculum_id_and_identifier(params[:school][user.id.to_s], params[:semester][user.id.to_s], params[:curriculum][user.id.to_s], params[:identifier][user.id.to_s])
  end

  def create_course(user,params)
    if valid_course(user,params)
      presurvey = create_presurvey(user,params)
      postsurvey = create_postsurvey(user,params)
      course = create_valid_course(user, params, presurvey, postsurvey)
      save_course_presurvey_postsurvey(course, presurvey, postsurvey)
      return course
    end
  end

  def save_course_presurvey_postsurvey(course, presurvey, postsurvey)
    presurvey.course_id = course.id
    postsurvey.course_id = course.id
    presurvey.save!
    postsurvey.save!
  end

  def create_valid_course(user, params, presurvey, postsurvey)
    Course.create!(
                   :school_id => params[:school][user.id.to_s],
                   :semester => params[:semester][user.id.to_s],
                   :curriculum_id => params[:curriculum][user.id.to_s],
                   :total_students => 0,
                   :presurvey_id => presurvey.id,
                   :postsurvey_id => postsurvey.id,
                   :active => 1,
                   :identifier => params[:identifier][user.id.to_s]
                   )
  end

  def create_presurvey(user, params)
    Presurvey.create!(:curriculum_id => params[:curriculum][user.id.to_s],
                      :data => {},
                      :total => {}
                      )
  end

  def create_postsurvey(user, params)
    Postsurvey.create!(:curriculum_id => params[:curriculum][user.id.to_s],
                       :data => {},
                       :total => {}
                       )
  end
end
