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
    And I fill in "First Name" with "Amir"
    And I fill in "Last Name" with "Khodaei"
    And I fill in "Email Address" with "amirk88@gmail.com"
    And I select "UC Berkeley" from "College"
    And I select "school1" from "School Name"
    And I select "Alameda" from "School County"
    And I select "Berkeley" from "School City"
    And I select "District" from "School District"
    And I select "Fall" from "Survey Period"
    And I select "2012" from "date_year"
    And I fill in "user_password" with "password"
    And I fill in "user_confirm_password" with "password"
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
    
  Scenario: school name should be in drop-down menu
    Given I am on the signup page
    Then I should see "school_name" in drop-down menu

  Scenario: county name should be in drop-down menu
    Given I am on the signup page
    Then I should see "school_county" in drop-down menu
    
  Scenario: school district should be in drop-down menu
    Given I am on the signup page
    Then I should see "school_district" in drop-down menu
    
  Scenario: school city should be in drop-down menu
    Given I am on the signup page
    Then I should see "school_city" in drop-down menu
