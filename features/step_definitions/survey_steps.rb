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


Given /the following curriculum exist/ do |table|
  table.hashes.each do |result|
    name = result[:name]
    Curriculum.create!(:name=>name)
  end
end


Given /the following sections exist/ do |table|
  table.hashes.each do |result|
    name = result[:name]
    objective = result[:objective]
    stype = result[:stype]
    curriculum_id = result[:curriculum_id]
    Section.create!(:name=>name,:objective=>objective,:stype=>stype,:curriculum_id=>curriculum_id)
  end
end


Given /the following questions exist/ do |table|
  table.hashes.each do |result|
    name = result[:name]
    qtype = result[:qtype]
    msg1 = result[:msg1]
    msg2 = result[:msg2]
    section_id = result[:section_id]
    Question.create!(:name=>name, :qtype=>qtype, :msg1=>msg1, :msg2=>msg2, :section_id=>section_id)
  end
end
