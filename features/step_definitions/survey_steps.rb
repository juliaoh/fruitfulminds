Given /the following pre-results 1 exist/ do |results_table|
  results_table.hashes.each do |result|
    Presurvey::Part1.create!(result)
  end
end

Given /the following pre-results 2 exist/ do |results_table|
  results_table.hashes.each do |result|
    Presurvey::Part2.create!(result)
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
