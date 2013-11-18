Feature: allow admin users to add and modify schools

  As an administrator
  So that I can add and modify colleges
  I want to have the data in an easy to access location

Background: results are to be added to database

  
  Given the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | District |

  And the following colleges exist:
    | name        |
    | UC Berkeley |

  And the following users exist:
    | email                | password | name         | profile | pending  | 
    | alwong8@berkeley.edu | aaaaaa   | Alvin Wong   | admin   |     1    |

  And the following schools exist:
    | name 	| county    | city 	  | district |
    | "school1" | "Alameda" | "Berkeley"  | District |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And the following colleges exist:
    | name       |
    | "college1" |

  And   I login as user "alwong8@berkeley.edu" with password "aaaaaa"
  And   I am on the portal page

Scenario: add new college
  When  I follow "Add New College"
  Then  I should be on the Add New College page
  And   I fill in "college_name" with "UCB"
  And   I press "Save Changes"
  Then  I should see "Successfully created college."

Scenario: edit existing college
  When  I follow "Show All Colleges"
  Then  I should be on the All Colleges page
  And   I press "edit_college_1"
  And   I fill in "college_name" with "foo"
  And   I press "Save Changes"
  Then  I should see "Successfully updated college."

Scenario: add new college
  When  I follow "Add New College"
  Then  I should be on the Add New College page
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

Scenario: edit existing college
  When  I follow "Show All Colleges"
  Then  I should be on the All Colleges page
  And   I press "edit_college_1"
  And   I fill in "college_name" with ""
  And   I press "Save Changes"
  Then  I should see "Fields cannot be left blank."

