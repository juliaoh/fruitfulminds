Feature: Provide textual guidance

  As an admin
  So that I can easily fill out the curriculum generation correctly
  I want to see sample texts in fields of survey template creation

Background: logged in as admin

  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password

@javascript
Scenario: In adding new survey template, admin would like to see example text to correctly fill out each part 
  When I am on the new survey template page
  Then I should see "ex. Third Grade Curriculum" in for javascript "surveyname"
  And I should see "ex. Nutrition related diseases" in for javascript "sname1"
  And I should see "ex. Discuss the relationship between nutrition and health" in for javascript "sobjective1"
  And I should see "ex. Section 1 Question 1" in for javascript "s1q1name"
  And I should see "ex. Factors that may lead to type 2 diabetes" in for javascript " 