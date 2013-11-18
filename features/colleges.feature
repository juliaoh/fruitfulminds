Feature: allow admin users to add and modify schools

  As an administrator
  So that I can add and modify colleges
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given dataset1 is set up
  And   I am logged in as "admin@gmail.com" with "123f5" as my password
  And   I am on the portal page

Scenario: add new college
  Given I am on the Add New College page
  And   I fill in "college_name" with "UCB"
  And   I press "Save Changes"
  Then  I should see "Successfully created college."

Scenario: edit existing college
  Given I am on the All Colleges page
  And   I press "edit_college_1"
  And   I fill in "college_name" with "foo"
  And   I press "Save Changes"
  Then  I should see "Successfully updated college."

Scenario: add new college
  Given I am on the Add New College page
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

Scenario: edit existing college
  Given I am on the All Colleges page
  And   I press "edit_college_1"
  And   I fill in "college_name" with ""
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

