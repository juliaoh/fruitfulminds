Feature: add survey results

  As an ambassador
  So that I can generate survey reports
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given dataset1 is set up
  And   I am logged in as "admin@gmail.com" with "123f5" as my password
  And   I am on the portal page

Scenario: add new survey results to database
  When I follow "Show Pre-Survey"
  When I press "Edit Pre-Survey"
  And I fill in "question1" with "10"
  And I fill in "question2" with "10"
  And I fill in "question3" with "1"
  And I press "Save Changes"
  Then I should be on the portal page
  And I should see "survey results added"

Scenario: sad path for not filling in all of the survey questions
  When I follow "Add Survey Results"
  Then I should be on the Add new survey results page
  And I select "post_survey 1"
  And I fill in "q1" with "1"
  And I fill in "q2" with "1"
  And I press "Save Changes"
  Then I should be on the add new survey results page
  And I should see "Please fill in number of students."

