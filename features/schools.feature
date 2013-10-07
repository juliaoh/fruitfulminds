Feature: allow admin users to add and modify schools

  As an administrator
  So that I can add and modify schools
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1     |

  Given the following schools exist:
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And   I am logged in as amir
  And   I am on the portal page

Scenario: add new school
  When  I follow "Add New School"
  Then  I should be on the Add New School page
  And   I fill in "school_name" with "names"
  And   I fill in "school_county" with "counties"
  And   I fill in "school_city" with "cities"
  And   I press "Save Changes"
  Then  I should see "School successfully created."

Scenario: edit existing school
  When  I follow "Show All Schools"
  Then  I should be on the All Schools page
  And   I press "edit_school_1"
  And   I fill in "school_name" with "foo"
  And   I fill in "school_county" with "bar"
  And   I fill in "school_city" with "baz"
  And   I press "Save Changes"
  Then  I should see "School successfully updated."

Scenario: add new school
  When  I follow "Add New School"
  Then  I should be on the Add New School page
  And   I fill in "school_county" with "counties"
  And   I fill in "school_city" with "cities"
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

Scenario: edit existing school
  When  I follow "Show All Schools"
  Then  I should be on the All Schools page
  And   I press "edit_school_1"
  And   I fill in "school_name" with "foo"
  And   I fill in "school_county" with ""
  And   I fill in "school_city" with "baz"
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."
