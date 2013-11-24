Feature: Administrator survey creation
  As an administrator
  So that I can have more control over the survey
  I want to add new types of surveys

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

  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the portal page

@javascript
Scenario: add new survey results to a new survey record in database
  When I am on the new survey template page
  And I fill in "surveyname" with "Survey 1"
  And I fill in for javascript "sname1" with "Section 1"
  And I fill in for javascript "stype1" with "Multiple Choice"
  And I fill in "sobjective1" with "Teaching students about fruits"
  And I fill in "s1q1name" with "Section 1 Question 1"
  And I fill in "s1q1strength" with "Students understand different fruits"
  And I fill in "s1q1weakness" with "Students do not understand anything at all"
  And I press "Add Question"
  And I should see "Question Name"
  And I fill in "s1q2name" with "Section 1 Question 2"
  And I fill in "s1q2strength" with "Students understand different bananas"
  And I fill in "s1q2weakness" with "Students do not understand anything at all"
  And I press "Add Section"
  And I fill in for javascript "sname2" with "Section 2"
  And I fill in for javascript "stype2" with "Efficacy"
  And I fill in "sobjective2" with "Seeing students are learning"
  And I fill in "s2q1name" with "Section 2 Question 1"
  And I fill in "s2q1strength" with "Students agree"
  And I fill in "s2q1weakness" with "Students do not agree with anything at all"
  And I press "Save Changes"
  Then I should be on the survey templates page
  And I should see "New Survey successfully added."

Scenario: question with no name results to a sad path
  When I am on the new survey template page
  Then I should be on the new survey template page
  And I press "Save Changes"
  Then I should see "There are blank fields"
  Then I should be on the new survey template page