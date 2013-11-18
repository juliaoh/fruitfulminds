class SessionsController < ApplicationController
  skip_before_filter :current_user
  before_filter :logged_in, :only => [:new]

  def create
    user = User.where(:email => params[:user][:email]).first
    if user && user.authenticate(params[:user][:password])
      if user.pending?
        create_handle_pending_user()
      else
        create_handle_admin(user)
      end
    else
      flash[:warning] = "Incorrect #{user.nil? ? 'email/' : ''}password! Please try again."
      redirect_to login_path
    end
  end

  def create_handle_pending_user()
    flash[:warning] = %Q{
          You are not approved yet.\n
          You will receive an email upon approval/disapproval.}
    redirect_to login_path and return
  end

  def create_handle_admin(user)
    session[:user_id] = user.id
    if user.admin? and User.where(:pending => 0).length != 0
      redirect_to pending_users_path and return
    else
      redirect_to '/portal' and return
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end


end
