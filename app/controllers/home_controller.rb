class HomeController < ApplicationController
  def portal
    courses = Course.all
    if @current_user.admin?
      courses = Course.all
    else
      courses = @current_user.courses
    end
    @active_courses = courses.select { |course| course.active == 0 }
    @inactive_courses = courses.select { |course| course.active == 1 }
    @active_courses.sort! do |a, b|
      a.compare_name_and_semester(b)
    end
    @inactive_courses.sort_by! { |course| course.name }
  end
end
