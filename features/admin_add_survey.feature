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

Scenario: add new survey results to a new survey record in database
  When I follow "Add New Survey"
  Then I should be on the Add new survey page
  And I fill in "Survey name" with "Pre Survey 1"
  And I fill in "Question 1 Name" with "Section 1 Question 1"
  And I select "Question 1 Type" with "Correctness"
  And I press "Add Question"
  And I should see "Question 2 Name"
  And I fill in "Question 2 Name" with "Efficacy 1"
  And I select "Question 2 Type" with "Efficacy"
  And I press "Complete"
  Then I should be on the portal page
  And I should see "New Survey successfully added."

Scenario: same question name results to a sad path
  When I follow "Add New Survey"
  Then I should be on the Add new survey page
  And I fill in "Survey name" with "Pre Survey 1"
  And I fill in "Question 1 Name" with "Section 1 Question 1"
  And I select "Question 1 Type" with "Correctness"
  And I press "Add Question"
  And I should see "Question 2 Name"
  And I fill in "Question 2 Name" with "Section 1 Question 1"
  And I select "Question 2 Type" with "Correctness"
  And I press "Complete"
  Then I should see "There are questions with same name. Please fix it!"
  And I should be on the Add new survey page

Scenario: question with no name results to a sad path
  When I follow "Add New Survey"
  Then I should be on the Add new survey page
  And I fill in "Survey name" with "Pre Survey 1"
  And I fill in "Question 1 Name" with "Section 1 Question 1"
  And I select "Question 1 Type" with "Correctness"
  And I press "Add Question"
  And I should see "Question 2 Name"
  And I press "Complete"
  Then I should see "There are questions with no names. Please fix it!"
  And I should be on the Add new survey page

Scenario: question with no name results to a sad path
  When I follow "Add New Survey"
  Then I should be on the Add new survey page
  And I fill in "Survey name" with "Pre Survey 1"
  And I fill in "Question 1 Name" with "Section 1 Question 1"
  And I select "Question 1 Type" with "Correctness"
  And I press "Add Question"
  And I should see "Question 2 Name"
  And I fill in "Question 2 Name" with "Section 1 Question 2"
  And I press "Complete"
  Then I should see "Question types are not selected. Please fix it!"
  And I should be on the Add new survey page
