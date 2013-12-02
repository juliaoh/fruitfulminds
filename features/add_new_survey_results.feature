Feature: add survey results

  As an ambassador
  So that I can generate survey reports
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given dataset1 is set up
  And I am logged in as "approved_user@gmail.com" with "12323" as my password
  And I am on the portal page


Scenario: add new survey results to database
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "new_data[absolute_total_students]" with "35"
  And I fill in "new_data[2][student_subtotal]" with "5"
  And I fill in "new_data[2][1]" with "2"
  And I fill in "new_data[2][2]" with "3"
  And I press "Save Changes"
  Then I should see "Survey updated successfully."
