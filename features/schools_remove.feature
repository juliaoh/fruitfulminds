Feature: allow admin users to remove schools

  As an administrator
  So that I can control which schools are available
  I want to be able to delete schools from the database.

Background: results are to be added to database
  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password
 
@javascript
Scenario: delete existing school - (happy path)
  When  I am on the All Schools page
  And   I press "edit_school_1"
  And   I press "Delete"
  And   I confirm popup
  Then  I should be on the All Schools page
  And   I should see "School successfully deleted."

@javascript
Scenario: delete existing school - cancel (sad path)
  When  I am on the All Schools page
  And   I press "edit_school_1"
  And   I press "Delete"
  And   I dismiss popup
  And   I press "Save Changes"
  Then  I should be on the All Schools page
  And   I should see "school1"
  And   I should see "School successfully updated."
