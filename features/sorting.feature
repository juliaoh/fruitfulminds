Feature: sorting schools, colleges, users, pending users, homepage

  As an administrator
  So that the data can be organized
  I want to see everything sorted correctly

Scenario: Sorting Happy Path -- everything sorted
  Given the sorting database is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the pending users page
  Then I should see "Cherry" before I see "Grape"
  And I am on the all users page
  Then I should see "Apple" before I see "Banana"
  And I am on the All Colleges page
  Then I should see "Happy Fruits" before I see "UC Berkeley"
  And I am on the All Schools page
  Then I should see "Fruity Pebbles" before I see "School1"
  And I am on the portal page
  Then I should see "Fruity Pebbles" before I see "School1"

Scenario: Sorting Sad Path -- nothing there to be sorted, still better not break  Given the empty database is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password
  And I am on the pending users page
  Then I should not see "Cherry"
  Then I should not see "Grape"
  And I am on the all users page
  Then I should not see "Banana"
  Then I should not see "Apple"
  And I am on the All Colleges page
  Then I should not see "Happy Fruits"
  Then I should not see "UC Berkeley"
  And I am on the All Schools page
  Then I should not see "Fruity Pebbles"
  Then I should not see "School1"
  And I am on the portal page
  Then I should not see "Fruity Pebbles"
  Then I should not see "School1"
