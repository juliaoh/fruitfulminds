class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    if @current_user
      @school = @current_user.school
    else
      redirect_to login_path
    end
  end

  def admin_only
    if not @current_user.admin?
      flash[:warning] = "You do not have access to the requested page"
      redirect_to portal_path
    end
  end

  def logged_in
    if session[:user_id]
      flash[:warning] = "You are already logged in."
      redirect_to portal_path
    end
  end

  def valid_email?(email, options = {})
    results = ValidatesEmailFormatOf::validate_email_format(email)

    if results.nil?
      return true
    else
      return false
    end
  end

end
