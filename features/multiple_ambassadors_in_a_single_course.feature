Feature: work with other ambassadors to input data

  As an ambassador
  So that I can split work with other people
  I want multiple ambassadors to be assigned to courses

Background:
  Given the multiple ambassador dataset is set up
  And I am logged in as "ambassador1@gmail.com" with "qwerty" as my password
  And I am on the portal page

Scenario: Pre-Surveys should have multiple users
  And I follow "Show Pre-Survey"
  Then I should see "Ambassador1"
  And I should see "Ambassador2"
  And the page should contain the "1_1" field
  And the page should contain the "1_2" field
  And the page should contain the "2_1" field
  And the page should contain the "2_2" field

Scenario: see fellow ambassador's pre-survey edits
  And I follow "Show Pre-Survey"
  And I press "Edit Pre-Survey"
  And I fill in "new_data[2][1]" with "55"
  And I fill in "new_data[2][2]" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador2@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Pre-Survey"
  Then the "2_1" field should contain "55"
  And the "2_2" field should contain "56"

Scenario: not see rival ambassador's pre-survey edits (sad path)
  And I follow "Show Pre-Survey"
  And I press "Edit Pre-Survey"
  And I fill in "new_data[2][1]" with "55"
  And I fill in "new_data[2][2]" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador3@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Pre-Survey"
  Then the page should not contain the "2_1" field
  And the page should not contain the "2_2" field

Scenario: Post-Surveys should have multiple users
  And I follow "Show Post-Survey"
  Then I should see "Ambassador1"
  And I should see "Ambassador2"
  And the page should contain the "1_1" field
  And the page should contain the "1_2" field
  And the page should contain the "2_1" field
  And the page should contain the "2_2" field


Scenario: see fellow ambassador's post-survey edits
  And I follow "Show Post-Survey"
  And I press "Edit Post-Survey"
  And I fill in "new_data[2][1]" with "55"
  And I fill in "new_data[2][2]" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador2@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Post-Survey"
  Then the "2_1" field should contain "55"
  And the "2_2" field should contain "56"

Scenario: not see rival ambassador's post-survey edits (sad path)
  And I follow "Show Post-Survey"
  And I press "Edit Post-Survey"
  And I fill in "new_data[2][1]" with "55"
  And I fill in "new_data[2][2]" with "56"
  And I press "Save Changes"
  And I am on the logout page
  And I am logged in as "ambassador3@gmail.com" with "qwerty" as my password
  And I am on the portal page
  And I follow "Show Post-Survey"
  Then the page should not contain the "2_1" field
  And the page should not contain the "2_2" field

