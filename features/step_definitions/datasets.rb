Given /^dataset1 is set up$/ do
  steps %Q{
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
  }
end
