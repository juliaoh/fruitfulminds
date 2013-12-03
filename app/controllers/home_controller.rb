class HomeController < ApplicationController
  include ActiveCoursesHelper
  def portal
    get_active_inactive(@current_user)
  end
end
