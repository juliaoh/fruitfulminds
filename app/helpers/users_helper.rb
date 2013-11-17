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

end
