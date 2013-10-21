Feature: Food journals should not be shown anymore on the site
  As an administrator and an ambassador
  I want to be able to not see the Food journals button
  So that I don't get confused since they won't be implemented.

  Background:
    Given the following profiles exist:
      | label      |
      | admin      |
      | ambassador |
    And the following schools exist:
      | name        | county  | city     | district |
      | UC Berkeley | Alameda | Berkeley | Berkeley |
    And the following school_semesters exist:
      | school_id | name | year |
      | 1         | Fall | 2013 |
    And the following users exist:
      | email                   | password | name  | profile_id | school_semester_id |
      | admin@fruitfulminds.com | password | Admin | 1          | 3                  | 
      | alwong8@berkeley.edu    | a1b3b345 | Alvin | 2          | 3                  |
      | kevinyeun@berkeley.edu  | 32ddf34r | Kevin | 3          | 4                  |

    And I login as user "alwong8@berkeley.edu" with password "a1b3b345"
    And I am on the portal page

    Scenario: Admin should not see link to Food Journals on the portal page
      Given I am on the portal page
      Then I should not see "Food Journal"