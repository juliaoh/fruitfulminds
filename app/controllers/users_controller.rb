class UsersController < ApplicationController

  skip_before_filter :current_user, :only => [:new, :create, :tos]
  before_filter :admin_only, :only => [:all_users, :update_all_users, :pending_user, :update_pending_user, :delete_pending_user]
  before_filter :logged_in, :only => [:new]

  # show user info and profile
  def show
  end

  # renders sign up page
  def new
  end

  def tos
  end

  def edit
  end

  def create
    if user_filled_all_fields? params

        firstName = params[:user][:firstname]
        lastName = params[:user][:lastname]
        email = params[:user][:email]
        password = params[:user][:password]
        confirm = params[:user][:confirm_password]
        college = params[:user][:college]

        schoolName = params[:school][:name]
        schoolCounty = params[:school][:county]
        schoolDistrict = params[:school][:district]
        schoolCity = params[:school][:city]

        semesterName = params[:semester][:name]
        semesterYear = params[:date][:year]

        tos = params[:tos]

        if tos.nil?
            flash[:warning] = "You have to accept the TOS in order to register"
        elsif not valid_email?(email)
            flash[:warning] = "Not a valid email address"
        elsif password.length < 6
            flash[:warning] = "Password must have 6 characters or more"
        elsif not password.eql? confirm
            flash[:warning] = "Passwords did not match"
        else
          ActiveRecord::Base.transaction do
            begin
            # create user
            @user = User.create(:name => "#{firstName} #{lastName}",
                                :email => email,
                                :password => password,
                                :college => college,
                                :profile_id => Profile.find_by_label("ambassador").id)
            # add user's id to :pending_users table
            PendingUser.create!(:user_id => @user.id,
                                :school_name => schoolName,
                                :school_city => schoolCity,
                                :school_county => schoolCounty,
                                :school_district => schoolDistrict,
                                :semester_name => semesterName,
                                :semester_year => semesterYear)
            rescue Exception => e
              @user = nil
            end
          end
          if @user
            UserMailer.notify_admin(@user).deliver
            flash[:notice] = "Thank you for registering, a confirmation will be sent to you shortly"
            redirect_to login_path and return
          else
            flash[:warning] = "Registration Failed"
          end
        end
        redirect_to signup_path and return
    else
        flash[:warning] = "Please fill in all fields"
        redirect_to signup_path and return
    end
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
      if !user.admin? and !PendingUser.find_by_user_id(user.id)
        @all_users << {
          :id => user.id,
          :email => user.email,
          :name => user.name,
          :college => user.college,
          :school_id => user.school_semester.school_id,
          :semester_name => user.school_semester.name,
          :semester_year => user.school_semester.year
        }
      end
    end
  end

  def update_all_users
    deleted_users = ""
    updated_users = ""

    if not params[:deletes].nil?
      params[:deletes].keys.each do |uid|
        user = User.find_by_id(uid)
        user.destroy if user && !user.admin?
      end
    end

    if not params[:updates].nil?
      params[:updates].keys.each do |uid|

        # fields that admin might have modified
        user_college = params[:colleges][uid]
        school_id = params[:schools][uid]
        semester_name = params[:semester_names][uid] # Fall, Winter, Spring, Summer
        semester_year = params[:semester_years][uid] # a 4-digit number, e.g 2012

        semester = SchoolSemester.where(:school_id => school_id, :name => semester_name, :year => semester_year).first
        # create a new school_semester if a semester with given info does not exist
        semester = SchoolSemester.create!(:school_id => school_id, :name => semester_name, :year => semester_year) if semester.nil?

        # update user attributes and delete the user from pending_users table
        user = User.find_by_id(uid)
        user.college = user_college
        user.school_semester_id = semester.id
        user.save
      end
    end

    redirect_to all_users_path and return
  end

  def pending_users
    @pending_users = []
    PendingUser.all.each do |puser|
      user = User.find(puser.user_id)
      @pending_users << {
        :id => user.id,
        :name => user.name,
        :email => user.email,
        :college => user.college,
        :school_name => puser.school_name,
        :school_city => puser.school_city,
        :school_county => puser.school_county,
        :school_district => puser.school_district,
        :semester_name => puser.semester_name,
        :semester_year => puser.semester_year
      }
    end
  end

  def update_pending_users
    approved_users = ""
    disapproved_users = ""

    # Users to be approved
    if not params[:approves].nil?
      params[:approves].keys.each do |uid|

        # fields that admin might have modified
        user_college = params[:colleges][uid]
        school_name = params[:school_names][uid]
        school_city = params[:school_cities][uid]
        school_district = params[:school_districts][uid]
        school_county = params[:school_counties][uid]
        semester_name = params[:semester_names][uid] # Fall, Winter, Spring, Summer
        semester_year = params[:date][uid] # a 4-digit number, e.g 2012

        # find school with the given info
        #puts "name: #{school_name}\tcity: #{school_city}\tdistrict: #{school_district}\tcounty: #{school_county}"
        school = School.where(
            "lower(name) = :name and lower(city) = :city and lower(county) = :county and lower(district) = :district",
            :name => school_name.downcase,
            :city => school_city.downcase,
            :district => school_district.downcase,
            :county => school_county.downcase).first
        #puts "school: #{school}"
        #puts "schools:\t#{School.all}"
        # ask admin to add the school if this is a new school
        if school.nil?
          # TODO: Add a link to "Add School"
          flash[:warning] = "The following school could not be found. Click on \"Add School\" to add a new school"
          redirect_to pending_users_path and return
        end

        semester = SchoolSemester.where(:school_id => school.id, :name => semester_name, :year => semester_year).first
        # create a new school_semester if a semester with given info does not exist
        semester = SchoolSemester.create!(:school_id => school.id, :name => semester_name, :year => semester_year) if semester.nil?

        # update user attributes and delete the user from pending_users table
        user = User.find_by_id(uid)
        user.college = user_college
        user.school_semester_id = semester.id
        if user.save
          delete_pending_user(uid)
          UserMailer.user_approved_email(user).deliver
          approved_users << "#{User.find_by_id(uid).name} "
        end
      end
    end

    # Users to be disapproved
    if not params[:disapproves].nil?
      params[:disapproves].keys.each do |uid|
        user = User.find_by_id(uid)
        disapproved_users << "#{user.name} "
        user.destroy
        UserMailer.user_disapproved_email(user).deliver
        delete_pending_user(uid)
      end
    end

    flash[:notice] = %Q{#{approved_users.eql?("") ? "Nobody " : approved_users}were approved and #{disapproved_users.eql?("") ? "nobody " : disapproved_users}were disapproved}
    redirect_to pending_users_path and return
  end

  def delete_pending_user(user_id)
    ActiveRecord::Base.connection.execute(%Q{
      delete from pending_users where user_id = #{user_id}
    })
  end
end
