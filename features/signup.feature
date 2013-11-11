Feature: New user registeration

  As a new user
  So I can view the user portal and add survey data for my school
  I want to sign up in the website

Background: users have been added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | District |

  And the following school_semesters exist:
    | school_id | name | year |
    | 1         | Fall | 2012 |

  And the following colleges exist:
    | name          |
    |  UC Berkeley  |

  Scenario: user follows registration page
    Given I am on the login page
    And I follow "Register"
    Then I should be on the signup page

  Scenario: user registers successfully
    Given I am on the signup page
    And I fill in all of the registration text fields
    And I check "tos"
    And I press "Register"
    Then I should be on the login page
    And I should see "Thank you for registering, a confirmation will be sent to you shortly"

  Scenario: user does not check tos
    Given I am on the signup page
    And I fill in all of the registration text fields
    And I press "Register"
    Then I should be on the signup page
    And I should see "You have to accept the TOS in order to register"

  Scenario: passwords entered do not match
    Given I am on the signup page
    And I fill in all registration fields except password fields
    And I fill in "user_password" with "password"
    And I fill in "user_confirm_password" with "something_else"
    And I check "tos"
    And I press "Register"
    Then I should be on the signup page
    And I should see "Passwords did not match"

  Scenario: password too short
    Given I am on the signup page
    And I fill in all registration fields except password fields
    And I fill in "user_password" with "passw"
    And I fill in "user_confirm_password" with "passw"
    And I check "tos"
    And I press "Register"
    Then I should be on the signup page
    And I should see "Password must have 6 characters or more"

  Scenario: user leaves a registration field empty
    Given I am on the signup page
    And I fill in email and passwords with: "newuser@gmail.com", "password", "password"
    And I check "tos"
    And I press "Register"
    Then I should be on the signup page
    And I should see "Please fill in all fields"
    
  Scenario: school should be in drop-down menu
    Given I am on the signup page
    Then I should see "school_name" in drop-down menu
    
  @javascript
  Scenario: there should be a Terms of Service link
    Given I am on the signup page
    When I follow "Terms of Service"
    Then I should see the Terms of Service on a new page
