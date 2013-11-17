class UsersController < ApplicationController

  skip_before_filter :current_user, :only => [:new, :create, :tos]
  before_filter :admin_only, :only => [:index, :all_users, :update_all_users, :pending_user, :update_pending_user, :delete_pending_user]
  before_filter :logged_in, :only => [:new]

  # show user info and profile
  def show
  end

   # renders sign up page
  def new
    @course_names = Course.where(:active => true).collect { |c| [c.name, c.id ] }.uniq.sort
    @college_names = College.find(:all).map do |college|
      college.name
    end.uniq.sort
  end

  def tos
  end

  def index
    all_users
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

   # Checks if submission to create new ambassador is correct
  def correct_submission?(tos, user_params)
    conditions = [!tos.nil?,
                  valid_email?(user_params[:email]),
                  !(user_params[:password].length < 6),
                  user_params[:password].eql?(user_params[:confirm_password])]
    messages = ["You have to accept the TOS in order to register",
                "Not a valid email address",
                "Password must have 6 characters or more",
                "Passwords did not match"]
    if conditions.include?(false)
      flash[:warning] = messages[conditions.index(false)]
      return false
    end
    return true
  end

  # Generates the fields required for an ambassador.
  def generate_user_fields(user_params)
    return {:name => "#{user_params[:firstname]} #{user_params[:lastname]}",
            :email => user_params[:email],
            :password => user_params[:password],
            :college_id => College.find_by_name(user_params[:college]).id,
            :pending_course_id => user_params[:course],
            :pending => 0,
            :profile => "ambassador" }
  end

  def user_filled_all_fields? params_hash
    params_hash.each do |k,v|
      return false if v.blank?
      if k == "user" || k == "school" || k == "semester"
        v.each {|k2,v2| return false if v2.blank?}
      end
    end
    true
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
    @flash_message_hash = {}
    handle_pending_users(params)
    if @pending_users.length == 0
      redirect_to portal_path and return
    else
      redirect_to pending_users_path and return
    end
  end

  def handle_pending_users(params)
    if not params[:disapproves].nil? and not params[:approves].nil?
      handle_invalid_action(params)
    end
    if not params[:approves].nil?
      handle_all_approvals(params)
    end
    if not params[:disapproves].nil?
      handle_all_disapprovals(params)
    end
    handle_flash_message()
  end

  def handle_invalid_action(params)
    puts params
    keys = params[:approves].keys + params[:disapproves].keys
    keys.uniq.each do |uid|
      if params[:approves].has_key?(uid) and params[:disapproves].has_key?(uid)
        user = User.find_by_id(uid)
        @flash_message_hash[user.id] = "#{user.name} had both the approved and disapproved check boxes marked and hence left unchanged."
      end
    end
  end

  def handle_all_approvals(params)
    params[:approves].keys.each do |uid|
      user = User.find_by_id(uid)
      if not @flash_message_hash.has_key?(user.id)
        handle_approve_user(user, params)
        @flash_message_hash[user.id] = "#{user.name} was approved."
      end
    end
  end

  def handle_all_disapprovals(params)
    params[:disapproves].keys.each do |uid|
      user = User.find_by_id(uid)
      if not @flash_message_hash.has_key?(user.id)
        @flash_message_hash[user.id] = "#{user.name} was disapproved."
        handle_disapprove_user(user)
      end
    end
  end

  def handle_flash_message()
    flash_message_list = []
    @flash_message_hash.values.sort.each do |string|
      if string != ""
        flash_message_list << string
      end
    end
    if flash_message_list == []
      flash[:notice] = "Nobody was approved and nobody was disapproved.\n"
    else
      flash[:notice] = flash_message_list.join("<br>").html_safe
    end
  end

  def handle_disapprove_user(user)
    UserMailer.user_disapproved_email(user).deliver
    user.destroy
  end

  def handle_approve_user(user,params)
    begin
      user.update_attributes!({:college_id => params[:colleges][user.id.to_s].to_i, :pending => 1, :pending_course_id => nil})
      course = Course.find_by_id(params[:courses][user.id.to_s])
      course.users << user
      UserMailer.user_approved_email(user).deliver
    rescue ActiveRecord::RecordInvalid
      # impossible
      puts "better not be here!"
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
    newcourse = Course.find_by_id(params[:course][:name])
    @user.update_attributes!(:college => newcollege)
    handle_user_course_update(@user, newcourse)
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

end
