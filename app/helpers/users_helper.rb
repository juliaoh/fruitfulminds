module UsersHelper
  def correct_submission?(tos, user_params)
    conditions = [!tos.nil?,
                  valid_email?(user_params[:email]),
                  !(user_params[:password].length < 6),
                  user_params[:password].eql?(user_params[:confirm_password])]
    messages = ["You have to accept the TOS in order to register",
                "Not a valid email address",
                "Password must have 6 characters or more",
                "Passwords did not match"]
    return check_conditions(conditions, messages)
  end

  def check_conditions(conditions, messages)
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

    def handle_pending_users(params)
    flash_message_hash = {}
    if not params[:disapproves].nil? and not params[:approves].nil?
      flash_message_hash = handle_invalid_action(params, flash_message_hash)
    end
    if not params[:approves].nil?
      flash_message_hash = handle_all_approvals(params, flash_message_hash)
    end
    if not params[:disapproves].nil?
      flash_message_hash = handle_all_disapprovals(params, flash_message_hash)
    end
    handle_flash_message(flash_message_hash)
  end

  def handle_invalid_action(params, flash_message_hash)
    puts params
    keys = params[:approves].keys + params[:disapproves].keys
    keys.uniq.each do |uid|
      if params[:approves].has_key?(uid) and params[:disapproves].has_key?(uid)
        user = User.find_by_id(uid)
        flash_message_hash[user.id] = "#{user.name} had both the approved and disapproved check boxes marked and hence left unchanged."
      end
    end
    return flash_message_hash
  end

  def handle_all_approvals(params, flash_message_hash)
    params[:approves].keys.each do |uid|
      user = User.find_by_id(uid)
      if not flash_message_hash.has_key?(user.id)
        handle_approve_user(user, params)
        flash_message_hash[user.id] = "#{user.name} was approved."
      end
    end
    return flash_message_hash
  end

  def handle_all_disapprovals(params, flash_message_hash)
    params[:disapproves].keys.each do |uid|
      user = User.find_by_id(uid)
      if not flash_message_hash.has_key?(user.id)
        flash_message_hash[user.id] = "#{user.name} was disapproved."
        handle_disapprove_user(user)
      end
    end
    return flash_message_hash
  end

  def handle_flash_message(flash_message_hash)
    flash_message_list = []
    flash_message_hash.values.sort.each do |string|
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

end
