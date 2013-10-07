Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /^the following school_semesters exist/ do |school_semesters_table|
  school_semesters_table.hashes.each do |school_semester|
    SchoolSemester.create!(school_semester)
  end
end

Given /^I fill in all of the registration text fields$/ do
  steps %Q{
    Given I fill in "First Name" with "Amir"
    And I fill in "Last Name" with "Khodaei"
    And I fill in "Email Address" with "amirk88@gmail.com"
    And I fill in "College" with "Berkeley City College"
    And I fill in "School Name" with "school1"
    And I fill in "School County" with "Alameda"
    And I fill in "School District" with "District"
    And I fill in "School City" with "Berkeley"
    And I select "Fall" from "Survey Period"
    And I select "2012" from "date_year"
    And I fill in "user_password" with "password"
    And I fill in "user_confirm_password" with "password"
  }
end

Given /^I fill in all registration fields except password fields$/ do
  steps %Q{
    Given I fill in "First Name" with "Amir"
    And I fill in "Last Name" with "Khodaei"
    And I fill in "Email Address" with "amirk88@gmail.com"
    And I fill in "College" with "Berkeley City College"
    And I fill in "School Name" with "school1"
    And I fill in "School County" with "Alameda"
    And I fill in "School District" with "District"
    And I fill in "School City" with "Berkeley"
    And I select "Fall" from "Survey Period"
    And I select "2012" from "date_year"
  }
end

Given /^"(.*)" is a pending user for school "(.*)" and semester "(.*)\s*,\s*(.*)"$/ do |name, school_name, semester_name, semester_year|
  school = School.find_by_name(school_name)
  semester = SchoolSemester.where(:name => semester_name, :year => semester_year).first
  PendingUser.create!(
      :user_id => User.find_by_name(name).id,
      :school_name => school.name,
      :school_city => school.city,
      :school_county => school.county,
      :school_district => school.district,
      :semester_name => semester.name,
      :semester_year => semester.year)
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
