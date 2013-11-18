Feature: allow admin users to add and modify admins

  As an administrator
  So that I can add and modify admins
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile | pending |
    | amirk88@gmail.com  | 123f5    | amir khodaei | admin   | 1       |

  And   I am logged in as amir
  And   I am on the Create New Administrator page

Scenario: add new admin
  And   I fill in "user_name" with "names"
  And   I fill in "user_email" with "email@example.com"
  And   I fill in "user_password" with "cities"
  And   I fill in "user_confirm_password" with "cities"
  And   I press "Create account"
  Then  I should see "Successfully created new administrator."

Scenario: add new admin
  And   I fill in "user_name" with "names"
  And   I fill in "user_email" with "counties"
  And   I fill in "user_password" with "cities"
  And   I fill in "user_confirm_password" with "cities"
  And   I press "Create account"
  Then  I should see "Not a valid email address"

Scenario: add new admin
  And   I fill in "user_email" with "counties"
  And   I press "Create account"
  Then  I should see "Password must have 6 characters or more"

Scenario: add new admin
  And   I press "Create account"
  Then  I should see "Please fill in all fields"
