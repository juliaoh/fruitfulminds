class UsersController < ApplicationController
  include UsersHelper
  skip_before_filter :current_user, :only => [:new, :create, :tos]
  before_filter :admin_only, :only => [:index, :all_users, :update_all_users, :pending_user, :update_pending_user, :delete_pending_user]
  before_filter :logged_in, :only => [:new]

  # show user info and profile
  def show
  end

  # renders sign up page
  def new
    @school_names = School.all.collect { |s| ["#{s.name}, #{s.city}, #{s.county}", s.id ] }.uniq.sort
    @college_names = College.find(:all).map do |college|
      college.name
    end.uniq.sort
  end

  def tos
  end

  def index
    redirect_to all_users_path
  end

  def edit
  end

  def create
    if user_filled_all_fields? params
      user_fields = generate_user_fields(params[:user])
      if correct_submission?(params[:tos], params[:user])
        if create_user_if_valid(user_fields)
          redirect_to login_path and return
        else
          flash[:warning] = @user_error.message
        end
      end
    else
      flash[:warning] = "Please fill in all fields"
    end
    redirect_to signup_path and return
  end

  # Creates a user upon validity.
  def create_user_if_valid(user_fields)
    ActiveRecord::Base.transaction do
      begin
        @user = User.create!(user_fields)
        if @user
          UserMailer.notify_admin(@user).deliver
          flash[:notice] = "Thank you for registering, a confirmation will be sent to you shortly"
          return true
        end
        return false
      rescue Exception => e
        @user = nil
        @user_error = e
        return false
      end
    end
  end

  def update
  end

  def all_users
    @all_users = []
    User.all.each do |user|
      if !user.admin? and !user.pending?
        @all_users << user
      end
    end
  end

  def pending_users
    @pending_users = User.where(:pending => 0).sort
  end

  def update_pending_users
    @pending_users = User.where(:pending => 0)
    handle_pending_users(params)
    if @pending_users.length == 0
      redirect_to portal_path and return
    else
      redirect_to pending_users_path and return
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    @college = @user.college
    @course = @user.courses[0] ## Deal with 1 course right now.
  end

  def update
    @user = User.find_by_id(params[:id])
    newcollege = College.find_by_id(params[:college][:name])
    #newcourse = Course.find_by_id(params[:course][:name])
    @user.update_attributes!(:college => newcollege)
    #handle_user_course_update(@user, newcourse)
    redirect_to all_users_path and return
  end

  def handle_user_course_update(user, newcourse)
    if not user.courses[0].nil?
      user.courses[0].users.delete(user) ## Deal with 1 course right now.
    end
    newcourse.users << user
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to all_users_path and return
  end

  def remove_course
    user = User.find_by_id(params[:user])
    course = Course.find_by_id(params[:course])
    user.courses.delete(course)
    course.users.delete(user)
    course.save!
    user.save!
    redirect_to edit_user_path(params[:user])
  end
end
