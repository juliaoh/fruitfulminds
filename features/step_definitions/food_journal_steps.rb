Given /the following food journals exist/ do |results_table|
  results_table.hashes.each do |result|
    FoodJournal.create!(result)
  end
end
