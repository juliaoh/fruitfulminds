Feature: Administrator survey creation
  As an administrator
  So that I can have more control over the survey
  I want to edit new types of surveys

Background: results are to be added to database

  Given the following users exist:
    | email              | password | name         | profile        | pending |
    | admin@gmail.com    | 123f5    | Admin        | admin          |    1    |
    | amirk88@gmail.com  | 123f5    | amir khodaei | ambassador     |    1    |

  And the following schools exist:
    | name 	| county    | city 	  | district |
    | "school1" | "Alameda" | "Berkeley"  | District |

  And the following curriculum exist:
    | name        |
    | "Test Survey" |
    

  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the portal page

@javascript
Scenario: go to a survey edit page and click save
  When I am on the survey templates page
  When I follow "Test Survey"
  And I press "Save Changes"
  Then I should be on the survey templates page
  And I should see "Survey successfully updated."

Scenario: edit question with no name results to a sad path
  When I am on the survey templates page
  When I follow "Test Survey"
  And I fill in "surveyname" with ""
  And I press "Save Changes"
  Then I should see "There are blank fields"
 
@javascript
Scenario: Add a section to the survey
  When I am on the survey templates page
  When I follow "Test Survey"
  And I press "Add Section"
  And I fill in for javascript "sname1" with "Section 1"
  And I fill in for javascript "stype1" with "Efficacy"
  And I fill in "sobjective1" with "Seeing students are learning"
  And I press "Add Question"
  And I fill in "s1q1name" with "Section 1 Question 1"
  And I fill in "s1q1msg" with "Students agree"
  And I press "Save Changes"
  Then I should be on the survey templates page
  And I should see "Survey successfully updated."

