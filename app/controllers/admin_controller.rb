class AdminController < ApplicationController
  before_filter :admin_only

  def new
    user = params[:user]
    @admin_fields = User.new
    if user
      @admin_fields.email = user[:email]
      @admin_fields.name = user[:name]
      @admin_fields.password = user[:password]
    end
  end

  def edit
  end

  def create
    if not params[:user].values.all?{|v| v.empty?}
      name = params[:user][:name]
      email = params[:user][:email]
      password = params[:user][:password]
      confirm = params[:user][:confirm_password]

      if password.length < 6
        flash[:warning] = "Password must have 6 characters or more"
      elsif not valid_email? email
        flash[:warning] = "Not a valid email address"
      elsif not password.eql? confirm
        flash[:warning] = "Passwords did not match"
      else
        begin
          @user = User.create!(:name => name, :email => email, :password => password, :profile_id => Profile.find_by_label("admin").id)
          flash[:notice] = "Successfully created new administrator."
          redirect_to portal_path and return
        rescue ActiveRecord::RecordInvalid
          flash[:warning] = "Registration Failed"
        end
      end
    else
      flash[:warning] = "Please fill in all fields"
    end
    redirect_to new_admin_path(:user => fields)
  end

  def update
  end

  protected
  def fields
    {:name => params[:user][:name], :email => params[:user][:email]}
  end

end
