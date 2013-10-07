Feature: Admin approves/disapproves new users before they are given access to the portal page
  As an Administrator
  So that I can grant access only to those new ambassadors that I know about
  I want to approve/disapprove a new user's request to access the ambassador portal

  Background:
    Given the following profiles exist:
      | label      |
      | admin      |
      | ambassador |

    And the following schools exist:
      | name    | county  | city     | district |
      | school1 | Alameda | Berkeley | District |

    And the following school_semesters exist:
      | school_id | name | year |
      | 1         | Fall | 2012 |

    And the following users exist:
      | email                   | password | name          | profile_id | school_semester_id |
      | admin@gmail.com         | 123f5    | Admin         | 1          |                    |
      | approved_user@gmail.com | 12323    | Approved User | 2          | 1                  |
      | pending_user@gmail.com  | 2isd82   | Pending User  | 2          |                    |

    And "Pending User" is a pending user for school "school1" and semester "Fall, 2012"
    And I am logged in as "admin@gmail.com" with "123f5" as my password
    And I am on the portal page

  Scenario: Admin sees all pending users
    When I follow "Pending Users"
    Then I should be on the pending users page
    And I should see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"

  Scenario: Admin approves a pending user
    Given I am on the pending users page
    And I approve "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Pending User were approved and nobody were disapproved"

  Scenario: Admin disapproves a pending user
    Given I am on the pending users page
    And I disapprove "Pending User"
    And I press "Update"
    Then I should be on the pending users page
    And I should not see "pending_user@gmail.com"
    And I should not see "approved_user@gmail.com"
    And I should see "Nobody were approved and Pending User were disapproved"
