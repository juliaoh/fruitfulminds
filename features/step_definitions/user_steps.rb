Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|

    User.create!(user)
  end
end

Given /the following users have courses/ do |table|
  table.hashes.each do |result|
    user = User.find_by_id(result[:user_id])
    course = Course.find_by_id(result[:course_id])
    course.users << user
    course.save!
  end
end

Given /^the following school_semesters exist/ do |school_semesters_table|
  school_semesters_table.hashes.each do |school_semester|
    SchoolSemester.create!(school_semester)
  end
end

Given /^the following colleges exist/ do |colleges_table|
  colleges_table.hashes.each do |college|
    College.create!(college)
  end
end

Given /^the following colleges have users/ do |table|
  table.hashes.each do |result|
    user = User.find_by_id(result[:user_id])
    user.college_id = result[:college_id]
    user.save!
  end
end

Given /^I fill in all of the registration text fields$/ do
  steps %Q{
    Given I fill in "First Name" with "Kazuto"
    And I fill in "Last Name" with "Kirigaya"
    And I fill in "Email Address" with "sao@sao.com"
    And I select "UC Berkeley" from "College"
    And I select "school1, Berkeley, Alameda" from "School"
    And I select "Fall 2013" from "Semester"
    And I fill in "user_password" with "password"
    And I fill in "user_confirm_password" with "password"
  }
end

Given /^I fill in all registration fields except password fields$/ do
  steps %Q{
    Given I fill in "First Name" with "Kazuto"
    And I fill in "Last Name" with "Kirigaya"
    And I fill in "Email Address" with "sao@sao.com"
    And I select "UC Berkeley" from "College"
    And I select "school1, Berkeley, Alameda" from "School"
    And I select "Fall 2013" from "Semester"
  }
end

Given /^I am logged in as "(.*)" with "(.*)" as my password$/ do |email, password|
  steps %Q{
    Given I am on the login page
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "#{password}"
    And I press "Sign In"
  }
end

Given /^I (dis)?approve "(.*)"$/ do |dis,name|
  if dis
    step %Q{I check "disapproves[#{User.find_by_name(name).id}]"}
  else
    step %Q{I check "approves[#{User.find_by_name(name).id}]"}
  end
end

#Given /^I fill in full name, email and passwords with: "(.*)", "(.*)", "(.*)", "(.*)"$/ do |name, email, pass, conf_pass|
#  steps %Q{
#    Given I fill in "Full Name" with "#{name}"
#    And I fill in email and passwords with: "#{email}", "#{pass}", "#{conf_pass}"
#  }
#end

Given /^I fill in email and passwords with: "(.*)", "(.*)", "(.*)"$/ do |email, pass, conf_pass|
  steps %Q{
    Given I fill in "Email" with "#{email}"
    And I fill in "user_password" with "#{pass}"
    And I fill in "user_confirm_password" with "#{conf_pass}"
  }
end

Given /\s*I am logged in as amir$/ do
  steps %Q{
    And I am on the login page
    And I fill in "Email" with "amirk88@gmail.com"
    And I fill in "Pass" with "123f5"
    And I press "Sign In"}
end

Given /\s*I am logged in as john$/ do
  steps %Q{
And I am on the login page
And I fill in "Email" with "john@gmail.com"
And I fill in "Pass" with "12345"
And I press "Sign In"}
end


# From Fall 2013 -- Group 16

Given /\s*I login as user "(.*)" with password "(.*)"$/ do |email, pass|
  steps %Q{
  And I am on the login page
  And I fill in "Email" with "#{email}"
  And I fill in "Pass" with "#{pass}"
  And I press "Sign In"}
end
