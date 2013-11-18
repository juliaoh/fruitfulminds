Feature: Admin approves/disapproves new users before they are given access to the portal page
  As an Administrator
  So that I can grant access only to those new ambassadors that I know about
  I want to approve/disapprove a new user's request to access the ambassador portal

  Background:

    Given the following schools exist:
      | name    | county  | city     | district |
      | school1 | Alameda | Berkeley | District |

    And the following colleges exist:
      | name         |
      | UC Berkeley  |

    And the following presurveys exist:
      |   data            |    total        |
      |   PRESURVEY_DATA  | PRESURVEY_TOTAL |

    And the following postsurveys exist:
      | data            |   total           |
      | POSTSURVEY_DATA | POSTSURVEY_TOTAL  |

    And the following courses exist:
      | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
      | 1         | Fall 2013   | 1             | 25              | 1            | 1             | true   |

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_course_id |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |
      | approved_user@gmail.com | 12323    | Approved User | ambassador | 1       | 1          |                   |
      | pending_user@gmail.com  | 2isd82   | Pending User  | ambassador | 0       | 1          | 1                 |
      | pending_user2@gmail.com | 2isd82   | Pending User2 | ambassador | 0       | 1          | 1                 |

    And the following users have courses:
      | user_id  | course_id  |
      | 1        | 1          |
      | 2        | 1          |

    And I am logged in as "admin@gmail.com" with "123f5" as my password
    And I am on the pending users page

  Scenario: Admin sees all pending users
    And I should see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"

  Scenario: Admin approves a pending user
    And I approve "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was approved"

  Scenario: Admin disapproves a pending user
    And I disapprove "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was disapproved"

  Scenario: Admin approves all pending users
    And I approve "Pending User"
    And I approve "Pending User2"
    And I press "Update"
    Then I should be on the portal page
    And I should not see "pending_user@gmail.com"
    And I should not see "pending_user2@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User was approved"
    And I should see "Pending User2 was approved"

  Scenario: Admin approves no pending users
    And I press "Update"
    Then I should be on the pending users page
    And I should see "pending_user@gmail.com"
    And I should see "pending_user2@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Nobody was approved or disapproved."
