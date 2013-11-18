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

Scenario: see fellow ambassador's pre-survey edits
  And I press "Edit Pre-Survey"
  And I fill in "1" with "55"
  And I fill in "2" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador2@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Pre-Survey"
  Then I should see "55"
  And I should see "56"

Scenario: not see rival ambassador's pre-survey edits
  And I press "Edit Pre-Survey"
  And I fill in "1" with "55"
  And I fill in "2" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador3@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Pre-Survey"
  Then I should not see "55"
  And I should not see "56"


