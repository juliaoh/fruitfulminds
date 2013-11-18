Feature: Admin approves/disapproves new users before they are given access to the portal page
  As an Administrator
  So that I can grant access only to those new ambassadors that I know about
  I want to approve/disapprove a new user's request to access the ambassador portal

  Background:

    Given the data is set up
    And I am logged in as "admin@gmail.com" with "123f5" as my password
    And I am on the pending users page

  Scenario: Admin sees all pending users
    And I should see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"

  Scenario: Admin should see the current fields of the user
    And I should see "pending_user@gmail.com"
    And I should see "Pending User"
    And I should see "UC Berkeley"

  Scenario: Admin approves a pending user
    And I approve "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was approved"

  Scenario: Admin disapproves a pending user
    And I disapprove "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was disapproved"

  Scenario: Admin approves all pending users
    And I approve "Pending User"
    And I approve "Pending User2"
    And I press "Update"
    Then I should be on the portal page
    And I should not see "pending_user@gmail.com"
    And I should not see "pending_user2@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was approved"
    And I should see "Pending User2 was approved"

  Scenario: Admin approves no pending users
    And I press "Update"
    Then I should be on the pending users page
    And I should see "pending_user@gmail.com"
    And I should see "pending_user2@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Nobody was approved or disapproved."
