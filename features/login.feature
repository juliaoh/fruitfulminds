Feature: user logs into his/her portal

  As a user
  So that I can access the appropriate portal
  I want to login in with my username and password

  Scenario: An admin logs in with no pending user
    Given the no pending user dataset is set up
    And I am on the login page
    Given I fill in "Email" with "admin@gmail.com"
    And I fill in "user_password" with "123f5"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Pending Users"
    And I should see "Show Users"
    And I should see "Show Schools"
    And I should see "Show Colleges"

  Scenario: An admin logs in with a pending user
    Given dataset1 is set up
    And I am on the login page
    And I fill in "Email" with "admin@gmail.com"
    And I fill in "user_password" with "123f5"
    And I press "Sign In"
    Then I should be on the pending users page
    And I should see "pendinguser@gmail.com"
    And I should see "pendinguser2@gmail.com"

  Scenario: An ambassador logs in with no pending users
    Given the no pending user dataset is set up
    And I am on the login page
    Given I fill in "Email" with "approved_user@gmail.com"
    And I fill in "user_password" with "12323"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Show Courses"
    And I should see "Generate Course Report"

  Scenario: An ambassador logs in with a pending user
    Given dataset1 is set up
    And I am on the login page
    And I fill in "Email" with "approved_user@gmail.com"
    And I fill in "user_password" with "12323"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Show Courses"
    And I should see "Generate Course Report"

  Scenario: A pending user logs in
    Given dataset1 is set up
    And I fill in "Email" with "pending_user@gmail.com"
    And I fill in "user_password" with "2isd82"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "You are not approved yet"
    And I should see "You will receive an email upon approval/disapproval"

  Scenario: ambassador logs out
    Given the no pending user dataset is set up
    Given I fill in "Email" with "admin@gmail.com"
    And I fill in "user_password" with "123f5"
    And I press "Sign In"
    And I am on the portal page
    And I am on the logout page
    Then I should be on the login page

  Scenario: Incorrect password is entered
    Given the no pending user dataset is set up
    Given I fill in "Email" with "admin@gmail.com"
    And I fill in "user_password" with "password"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "Incorrect password! Please try again."

  Scenario: Incorrect username is entered
    Given I fill in "Email" with "kevinyeun@gmail.com"
    And I fill in "user_password" with "password"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "Incorrect email/password! Please try again."
