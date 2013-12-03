module ActiveCoursesHelper
  def get_active_inactive(user)
    courses = Course.all
    if user.admin?
      courses = Course.all
    else
      courses = user.courses
    end
    @active_courses = courses.select { |course| course.active == 1 and course.users.length > 0 }
    @inactive_courses = courses.select { |course| course.active == 0 and course.users.length > 0 }
    @active_courses.sort! do |a, b|
      a.compare_name_and_semester(b)
    end
    @inactive_courses.sort! do |a, b|
      a.compare_name_and_semester(b)
    end
  end
end
