Feature: add survey results

  As an ambassador
  So that I can generate survey reports
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              |

  And the following schools exist:
    | name 	| county    | city 	  | district |
    | "school1" | "Alameda" | "Berkeley"  | District |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     | Fall | 2011 |

  And the following curriculum exist:
    | name        |
    | curriculum1 |
    | curriculum2 |
    
  And the following questions exist:
    | name      |   qtype     |  msg1   |  msg2  |
    | question1 |   Efficacy  |    A    |   D    |
    | question2 |   Efficacy  |    B    |   E    |
    | question3 |   Efficacy  |    C    |   F    |


  And   I am logged in as amir
  And   I am on the portal page

Scenario: add new survey results to database
  When I press "1"
  When I press "Edit Presurvey"
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

