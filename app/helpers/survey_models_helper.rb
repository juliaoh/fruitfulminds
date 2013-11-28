module SurveyModelsHelper
  def get_data
    if data.nil?
      data = {}
    end
    course.users.each do |user|
      if not data.has_key?(user.id)
        data[user.id] = curriculum.get_empty_data
      end
    end
    save!
    return data
  end

  def get_subtotal
    if total.nil?
      total = {}
    end
    course.users.each do |user|
      if not total.has_key?(user.id)
        total[user.id] = 0
      end
    end
    save!
    return total
  end

  def current_or_all_users(current_user)
    if not current_user.admin?
      users = course.users.select do |user|
        user.id == current_user.id
      end
    else
      users = course.users
    end
    return users
  end
end
