class HomeController < ApplicationController
  def portal
    if @current_user.admin?
      @courses = Course.where(:active => 1)
    else
      @courses = @current_user.courses.select { |course| course.active == 1 }
    end
    @courses.sort_by! { |course| course.name }
  end

  def inactive_courses
    if @current_user.admin?
      @courses = Course.where(:active => 0)
    else
      @courses = @current_user.courses.select { |course| course.active == 0 }
    end
    @courses.sort_by! { |course| course.name }
  end
end
