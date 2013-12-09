Feature: allow admin users to edit users and their courses

  As an administrator
  So that I can control user fields
  I want to be able to edit users and their courses

Background:
  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password

Scenario: should be able to update an ambassador's fields
  And I am on the edit user page for user 2
  And I fill in "name" with "Cherry Picker"
  And I fill in "email" with "aa@aa.com"
  And I press "Update User Info"
  Then I should see "Cherry Picker has been updated."
  And I should be on the all users page

Scenario: sad path, should still update if nothing changed
  Given I am on the edit user page for user 2
  And I press "Update User Info"
  Then I should see "Approved User has been updated."

Scenario: add course to user
  Given I am on the edit user page for user 2
  And I select "school1, Berkeley, Alameda" from "school[2]"
  And I select "Fall 2014" from "semester[2]"
  And I select "curriculum1" from "curriculum[2]"
  And I press "Add"
  Then I should see "school1, Berkeley, Alameda, Fall 2014"

Scenario: delete course from user
  Given I am on the edit user page for user 2
  And I press "Remove"
  Then I should not see "School1, Berkeley, Alameda, Fall 2013"
