Feature: work with other ambassadors to input data

  As an ambassador
  So that I can split work with other people
  I want multiple ambassadors to be assigned to courses

Background:
  Given the multiple ambassador dataset is set up
  And I am logged in as "ambassador1@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Pre-Survey"

Scenario: Pre-Surveys should have multiple users
  Then I should see "Ambassador1"
  And I should see "Ambassador2"

Scenario: see fellow ambassador's survey edits
  And I press "Edit Pre-Survey"
  And I infinite loop 
