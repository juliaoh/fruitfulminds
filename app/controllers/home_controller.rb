class HomeController < ApplicationController
  def portal
    if @current_user.admin?
      @courses = Course.all
    else
      @courses = @current_user.courses
    end
  end
end
