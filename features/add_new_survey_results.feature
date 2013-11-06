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
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     | Fall | 2011 |

  And the following survey exist:
    | survey_name   |
    | post_survey 1 |
    | post_survey 2 |
    
  And the following questions exist:
    | survey_name   |   question_name  |       type       |
    | post_survey 1 |      q1          |    correctness   |  
    | post_survey 1 |      q2          |    correctness   |
    | post_survey 1 |      q3          |    correctness   |


  And   I am logged in as amir
  And   I am on the portal page

Scenario: add new survey results to database
  When I follow "Add Survey Results"
  Then I should be on the Add new survey results page
  And I select "post_survey 1"
  And I fill in "Total Number of Students" with "10"
  And I fill in "Total Number of Students Entering" with "10"
  And I fill in "q1" with "1"
  And I fill in "q2" with "1"
  And I fill in "q3" with "1"
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

