class HomeController < ApplicationController
  def portal
    if @current_user.admin?
      @active_courses = Course.where(:active => 1)
      @inactive_courses = Course.where(:active => 0)
    else
      @active_courses = @current_user.courses.select { |course| course.active == 1 }
      @inactive_courses = @current_user.courses.select { |course| course.active == 0 }
    end
    @active_courses.sort! do |a, b|
      a.compare_name_and_semester(b)
    end
    @inactive_courses.sort_by! { |course| course.name }
  end
end
