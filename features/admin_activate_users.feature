Feature: allow admin users to activate and deactivate users

As an administrator
So that I can control which users get access to the web portal
I want to have the ability to activate and deactivate users

Background:
  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password

Scenario: Deactivate user
  Given I am on the edit user page for user 2
  And I press "Deactivate User"
  Then I should see "Approved User has been deactivated."

Scenario: Sad Path -- Deactivated User should not be able to log on
  Given I am on the edit user page for user 2
  And I press "Deactivate User"
  Then I should see "Approved User has been deactivated."
  Given I am on the logout page
  And I am logged in as "approved_user@gmail.com" with "12323" as my password
  Then I should see "Your account has been deactivated. Please contact an administrator to reactivate your account."
  And I should be on the login page
  
Scenario: Activate user
  Given I am on the edit user page for user 2
  And I press "Deactivate User"
  Given I am on the edit user page for user 2
  And I press "Activate User"
  Then I should see "Approved User has been activated."