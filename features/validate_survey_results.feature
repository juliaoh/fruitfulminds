Feature: validate survey data

  As an ambassador
  So that I don't make mistakes
  I want to know if the data I have entered is invalid

Background: results are to be added to database

  Given dataset1 is set up
  And I am logged in as "approved_user@gmail.com" with "12323" as my password
  And I am on the portal page

Scenario: pass valid results
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "new_data[absolute_total_students]" with "35"
  And I fill in "new_data[2][student_subtotal]" with "10"
  And I fill in "new_data[2][1]" with "10"
  And I fill in "new_data[2][2]" with "10"
  And I press "Save Changes"
  Then I should see "Survey updated successfully."

Scenario: pass valid totals
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "new_data[absolute_total_students]" with "50"
  And I fill in "new_data[2][student_subtotal]" with "25"
  And I press "Save Changes"
  Then I should see "Survey updated successfully."

Scenario: fail invalid results
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "new_data[absolute_total_students]" with "35"
  And I fill in "new_data[2][student_subtotal]" with "10"
  And I fill in "new_data[2][1]" with "11"
  And I fill in "new_data[2][2]" with "10"
  And I press "Save Changes"
  Then I should see "Survey results invalid.  Total numbers inconsistent with data."

Scenario: fail invalid totals
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "new_data[absolute_total_students]" with "50"
  And I fill in "new_data[2][student_subtotal]" with "26"
  And I press "Save Changes"
  Then I should see "Survey results invalid.  Total numbers inconsistent with data."

