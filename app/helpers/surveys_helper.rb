module SurveysHelper
  def get_data
    course.users.each do |user|
      if not data.has_key?(user.id)
        data[user.id] = curriculum.get_empty_data
      end
    end
    return data
  end

  def get_subtotal
    course.users.each do |user|
      if not total.has_key?(user.id)
        total[user.id] = 0
      end
    end
    return total
  end
end
