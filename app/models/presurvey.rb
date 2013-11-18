class Presurvey < ActiveRecord::Base
  belongs_to :course
  belongs_to :curriculum
  serialize :data
  serialize :total

  def get_users
    course.users.sort! do |x, y|
      x[:id] <=> y[:id]
    end
    course.save!
    return course.users
  end

  def get_data
    course.users.each do |user|
      if not data.has_key?(user.id)
        data[user.id] = curriculum.get_empty_data
      end
    end
    return data
  end
end
