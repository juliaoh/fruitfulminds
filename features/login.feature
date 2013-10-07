Feature: user logs into his/her portal

  As a user
  So that I can access the appropriate portal
  I want to login in with my username and password

Background: users have been added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |                   |
    | amb@gmail.com      | ambpass  | New Amb      | 2          | 1                  |
    | amb2@gmail.com     | ambpass  | New Amb2     | 2          | 1                  |

  And the following schools exist:
    | name    | county  | city     |
    | school1 | Alameda | Berkeley |

  And the following school_semesters exist:
    | school_id | name | year |
    | 1         | Fall | 2012 |

  And I am on the login page

  Scenario: An admin logs in with no pending user
    Given I fill in "Email" with "amirk88@gmail.com"
    And I fill in "user_password" with "123f5"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Pending Users"
    And I should see "Add Pre-Survey Part 1 Results"
    And I should see "Add Pre-Survey Part 2 Results"
    And I should see "Add Post-Survey Results"
    And I should see "Preview Report/Add Ambassador Comments"

  Scenario: An admin logs in with a pending user
    Given "New Amb" is a pending user for school "school1" and semester "Fall, 2012"
    And I fill in "Email" with "amirk88@gmail.com"
    And I fill in "user_password" with "123f5"
    And I press "Sign In"
    Then I should be on the pending users page
    And I should see "amb@gmail.com"

  Scenario: An ambassador logs in with no pending users
    Given I fill in "Email" with "amb@gmail.com"
    And I fill in "user_password" with "ambpass"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Add Pre-Survey Part 1 Results"
    And I should see "Add Pre-Survey Part 2 Results"
    And I should see "Add Post-Survey Results"
    And I should see "Preview Report/Add Ambassador Comments"
    And I should not see "Pending Users"

  Scenario: An ambassador logs in with a pending user
    Given "New Amb2" is a pending user for school "school1" and semester "Fall, 2012"
    And I fill in "Email" with "amb@gmail.com"
    And I fill in "user_password" with "ambpass"
    And I press "Sign In"
    Then I should be on the portal page
    And I should see "Add Pre-Survey Part 1 Results"
    And I should see "Add Pre-Survey Part 2 Results"
    And I should see "Add Post-Survey Results"
    And I should see "Preview Report/Add Ambassador Comments"
    And I should not see "Pending Users"

  Scenario: A pending user logs in
    Given "New Amb" is a pending user for school "school1" and semester "Fall, 2012"
    And I fill in "Email" with "amb@gmail.com"
    And I fill in "user_password" with "ambpass"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "You are not approved yet"
    And I should see "You will receive an email upon approval/disapproval"

  Scenario: ambassador logs out
    Given I fill in "Email" with "amirk88@gmail.com"
    And I fill in "Pass" with "123f5"
    And I press "Sign In"
    And I am on the portal page
    And I follow "log_out"
    Then I should be on the login page

  Scenario: Incorrect password is entered
    Given I fill in "Email" with "amirk88@gmail.com"
    And I fill in "Pass" with "password"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "Incorrect password! Please try again."

  Scenario: Incorrect username is entered
    Given I fill in "Email" with "felix@wong.com"
    And I fill in "Pass" with "password"
    And I press "Sign In"
    Then I should be on the login page
    And I should see "Incorrect email/password! Please try again."
