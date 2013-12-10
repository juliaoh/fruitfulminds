Feature: Provide video tutorial link

  As an admin and ambassador
  So that I can learn how to use the website
  I want to see a link to the video tutorial on all pages

Background: logged in as admin

  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password

@javascript
Scenario: 
  When I am on the new survey template page
  Then I should see "Tutorial Video"