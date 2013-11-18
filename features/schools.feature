Feature: allow admin users to add and modify schools

  As an administrator
  So that I can add and modify schools
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given dataset1 is set up
  And I am logged in as "admin@gmail.com" with "123f5" as my password

Scenario: add new school
  When  I am on the Add New School page
  And   I fill in "school_name" with "names"
  And   I fill in "school_county" with "counties"
  And   I fill in "school_district" with "districts"
  And   I fill in "school_city" with "cities"
  And   I press "Save Changes"
  Then  I should see "School successfully created."

Scenario: edit existing school
  When  I am on the All Schools page
  And   I press "edit_school_1"
  And   I fill in "school_name" with "foo"
  And   I fill in "school_county" with "bar"
  And   I fill in "school_city" with "baz"
  And   I press "Save Changes"
  Then  I should see "School successfully updated."

Scenario: add new school
  When  I am on the Add New School page
  And   I fill in "school_county" with "counties"
  And   I fill in "school_city" with "cities"
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

Scenario: edit existing school
  When  I am on the All Schools page
  And   I press "edit_school_1"
  And   I fill in "school_name" with "foo"
  And   I fill in "school_county" with ""
  And   I fill in "school_city" with "baz"
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

