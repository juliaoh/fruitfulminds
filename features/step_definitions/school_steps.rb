Given /the following schools exist/ do |results_table|
  results_table.hashes.each do |result|
    School.create!(result)
  end
end

Given /^the following static content exists/ do |table|
  table.hashes.each do |info|
    StaticContent.create!(info)
  end
end
