Feature: allow admin users to remove colleges

  As an administrator
  So that I can control which colleges are available
  I want to be able to delete colleges from the database.

Background: results are to be added to database

  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the portal page

@javascript
Scenario: delete existing college - (happy path)
  Given I am on the All Colleges page
  And   I press "edit_college_1"
  And   I press "Delete"
  And   I confirm popup
  Then  I should be on the All Colleges page
  And   I should see "Successfully deleted college."

@javascript
Scenario: delete existing college - cancel (sad path)
  Given I am on the All Colleges page
  And   I press "edit_college_1"
  And   I press "Delete"
  And   I dismiss popup
  And   I press "Save Changes"
  Then  I should be on the All Colleges page
  And   I should see "UC Berkeley"
  And   I should see "Successfully updated college."
