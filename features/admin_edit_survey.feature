Feature: Administrator survey creation
  As an administrator
  So that I can have more control over the survey
  I want to edit new types of surveys

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | admin@gmail.com         | 123f5    | Admin         | 1          |                    |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              |

  And the following schools exist:
    | name 	| county    | city 	  | district |
    | "school1" | "Alameda" | "Berkeley"  | District |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     | Fall | 2011 |
    
  And the following curriculum exist:
    | name        |
    | "Test Survey" |
    

  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the portal page

@javascript
Scenario: go to a survey edit page and click save
  When I am on the survey templates page
  When I follow "Test Survey"
  #Then I should be on the edit survey template page
  And I press "Save Changes"
  Then I should be on the survey templates page
  And I should see "Survey successfully updated."

Scenario: edit question with no name results to a sad path
  When I am on the survey templates page
  When I follow "Test Survey"
  #Then I should be on the edit survey template page
  And I fill in "surveyname" with ""
  And I press "Save Changes"
  Then I should see "There are blank fields"
  Then I should be on the new survey template page
  
