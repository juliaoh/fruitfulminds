module SchoolsHelper
  def get_school_names
    School.all.collect { |s| ["#{s.name}, #{s.city}, #{s.county}", s.id ] }.uniq.sort
  end
end
