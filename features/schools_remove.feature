Feature: allow admin users to remove schools

  As an administrator
  So that I can control which schools are available
  I want to be able to delete schools from the database.

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email                | password | name         | profile_id | school_semester_id |
    | alwong8@berkeley.edu | aaaaaa   | Alvin Wong   | 1          |     1     |

  Given the following schools exist:
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And   I login as user "alwong8@berkeley.edu" with password "aaaaaa"
  And   I am on the portal page

@javascript
Scenario: delete existing school - (happy path)
  When  I follow "Show All Schools"
  Then  I should be on the All Schools page
  And   I press "edit_school_1"
  And   I press "Delete"
  And   I confirm popup
  Then  I should be on the All Schools page
  And   I should see "School successfully deleted."

@javascript
Scenario: delete existing school - cancel (sad path)
  When  I follow "Show All Schools"
  Then  I should be on the All Schools page
  And   I press "edit_school_1"
  And   I press "Delete"
  And   I dismiss popup
  And   I press "Save Changes"
  Then  I should be on the All Schools page
  And   I should see "school1"
  And   I should see "School successfully updated."