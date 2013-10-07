Then /^\s*I should see summary of the report with static contents$/ do
  static_content = StaticContent.first
  assert(!static_content.nil?)
  steps %Q{
    Then I should see "#{static_content.intro_title}"
    And I should see "#{static_content.introduction}"
    And I should see "#{static_content.objectives_title}"
    And I should see "#{static_content.objectives}"
    And I should see "#{static_content.strength_weakness_intro}"
    And I should see "#{static_content.strength_intro}"
    And I should see "#{static_content.weakness_intro}"
    And I should see "#{static_content.eval_title}"
    And I should see "#{static_content.summary}"
  }
end

Given /^\s*I initiated the report generation for "(.*)"$/ do |school|
  steps %Q{
    Given I select "#{school}" from "school"
    And I press "Generate Report"
  }
end

Given /^I should see a valid number as percentage$/ do
  regexp = /([0-9]+\.[0-9]+%)/ 
  page.text.should match(regexp) 
end
