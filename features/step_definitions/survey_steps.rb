Given /the following pre-results exist/ do |results_table|
  results_table.hashes.each do |result|
    school_id = result[:school_semester_id]
    result.delete(:school_semeseter_id)
    Presurvey.create!(:school_semester_id=>school_id, :data=>result)
  end
end

Given /the following post-results exist/ do |results_table|
  results_table.hashes.each do |result|
    Postsurvey.create!(result)
  end
end

Given /the following efficacies exist/ do |results_table|
  results_table.hashes.each do |result|
    Efficacy.create!(result)
  end
end
