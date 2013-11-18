Feature: home page set
  As an administrator
  So that I can see a good homepage
  I want to be sure that all the relevant fields are in the homepage

  Scenario: happy path -- a course exists
    Given the no pending user dataset is set up
    And I am logged in as "admin@gmail.com" with "123f5" as my password
    And I am on the portal page
    Then I should see "school1, Berkeley, Alameda, Fall 2013"
    And I should see "curriculum1"
 
  Scenario: sad path -- a course does not exist
    Given the no course dataset is set up
    And I am logged in as "admin@gmail.com" with "123f5" as my password
    And I am on the portal page
    Then I should not see "curriculum1"