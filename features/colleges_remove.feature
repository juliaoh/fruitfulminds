Feature: allow admin users to remove colleges

  As an administrator
  So that I can control which colleges are available
  I want to be able to delete colleges from the database.

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email                | password | name         | profile_id | school_semester_id |
    | alwong8@berkeley.edu | aaaaaa   | Alvin Wong   | 1          |     1     |

  And the following schools exist:
    | name 	| county    | city 	  | district |
    | "school1" | "Alameda" | "Berkeley"  | District |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And the following colleges exist:
    | name        |
    | "college1"  |

  And   I login as user "alwong8@berkeley.edu" with password "aaaaaa"
  And   I am on the portal page

@javascript
Scenario: delete existing college - (happy path)
  When  I follow "Show All Colleges"
  Then  I should be on the All Colleges page
  And   I press "edit_college_1"
  And   I press "Delete"
  And   I confirm popup
  Then  I should be on the All Colleges page
  And   I should see "Successfully deleted college."

@javascript
Scenario: delete existing college - cancel (sad path)
  When  I follow "Show All Colleges"
  Then  I should be on the All Colleges page
  And   I press "edit_college_1"
  And   I press "Delete"
  And   I dismiss popup
  And   I press "Save Changes"
  Then  I should be on the All Colleges page
  And   I should see "college1"
  And   I should see "Successfully updated college."
