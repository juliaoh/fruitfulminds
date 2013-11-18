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




Given /^the no pending user dataset is set up$/ do
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

    And the following users have courses:
      | user_id  | course_id  |
      | 1        | 1          |
      | 2        | 1          |
  }
end






Given /^the multiple ambassador dataset is set up$/ do
  steps %Q{
     Given the following schools exist:
      | name    | county  | city     | district |
      | school1 | Alameda | Berkeley | District |

    And the following colleges exist:
      | name         |
      | UC Berkeley  |

    And the following curriculum exist:
      | name        |
      | curriculum1 |

    And the following MC sections exist:
      | name     | objective            | stype           | curriculum_id |
      | section1 | test objective       | Multiple Choice | 1             |

    And the following questions exist:
      | name     | qtype           | msg1            | msg2         | section_id |
      | S1Q1     | Multiple Choice | S1Q1 strong     | S1Q1 weak    | 1          |
      | S1Q2     | Multiple Choice | S1Q2 strong     | S1Q2 weak    | 1          |

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
      | ambassador1@gmail.com   | qwerty   | Ambassador1   | ambassador | 1       | 1          |                   |
      | ambassador2@gmail.com   | qwerty   | Ambassador2   | ambassador | 1       | 1          |                   |

    And the following users have courses:
      | user_id  | course_id  |
      | 1        | 1          |
      | 2        | 1          |
      | 3        | 1          |
  }
end
