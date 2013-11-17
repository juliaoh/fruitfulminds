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

end
