Given /^dataset1 is set up$/ do
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
      | name     | qtype           | msg            | section_id |
      | S1Q1     | Multiple Choice | S1Q1 strong    | 1          |
      | S1Q2     | Multiple Choice | S1Q2 weak      | 1          |

    And the following presurveys exist:
      |   data            |    total        | course_id |
      |   PRESURVEY_DATA  | PRESURVEY_TOTAL |    1      |

    And the following postsurveys exist:
      | data            |   total           | course_id |
      | POSTSURVEY_DATA | POSTSURVEY_TOTAL  |    1      |


    And the following courses exist:
      | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
      | 1         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |
      | approved_user@gmail.com | 12323    | Approved User | ambassador | 1       | 1          |                   |                  |
      | pending_user@gmail.com  | 2isd82   | Pending User  | ambassador | 0       | 1          | 1                 | Fall 2013        |
      | pending_user2@gmail.com | 2isd82   | Pending User2 | ambassador | 0       | 1          | 1                 | Fall 2013        |

    And the following users have courses:
      | user_id  | course_id  |
      | 1        | 1          |
      | 2        | 1          |
  }
end



Given /^the no course dataset is set up$/ do
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

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |

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

    And the following curriculum exist:
      | name        |
      | curriculum1 |

    And the following presurveys exist:
      |   data            |    total        | course_id |
      |                   |     15          |    1      |

    And the following postsurveys exist:
      | data            |   total           | course_id |
      |                 |    15             |    1      |

    And the following courses exist:
      | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
      | 1         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |
      | approved_user@gmail.com | 12323    | Approved User | ambassador | 1       | 1          |                   |                  |

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
      | school2 | Alameda | Berkeley | District |

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
      | name     | qtype           | msg          | section_id |
      | S1Q1     | Multiple Choice | S1Q1 strong  | 1          |
      | S1Q2     | Multiple Choice | S1Q2 strong  | 1          |

  And the following presurveys exist:
    |   data            |    total        | course_id |
    |   PRESURVEY_DATA  | PRESURVEY_TOTAL | 1         |
    |   PRESURVEY_DATA  | PRESURVEY_TOTAL | 2         |

  And the following postsurveys exist:
    | data            |   total           | course_id |
    | POSTSURVEY_DATA | POSTSURVEY_TOTAL  | 1         |
    | POSTSURVEY_DATA | POSTSURVEY_TOTAL  | 2         |

    And the following courses exist:
      | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
      | 1         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |
      | 2         | Fall 2013   | 1             | 25              | 2            | 2             | 1      |

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |
      | ambassador1@gmail.com   | qwerty   | Ambassador1   | ambassador | 1       | 1          |                   |                  |
      | ambassador2@gmail.com   | qwerty   | Ambassador2   | ambassador | 1       | 1          |                   |                  |
      | ambassador3@gmail.com   | qwerty   | Ambassador3   | ambassador | 1       | 1          |                   |                  |

    And the following users have courses:
      | user_id  | course_id  |
      | 1        | 1          |
      | 2        | 1          |
      | 3        | 1          |
      | 4        | 2          |
  }
end


Given /^the sorting database is set up$/ do
  steps %Q{
     Given the following schools exist:
      | name           | county  | city     | district |
      | School1        | Alameda | Berkeley | District |
      | Fruity Pebbles | Fruit   | Fruit    | Fruit    |

    And the following colleges exist:
      | name         |
      | UC Berkeley  |
      | Happy Fruits |

    And the following curriculum exist:
      | name        |
      | curriculum1 |

    And the following MC sections exist:
      | name     | objective            | stype           | curriculum_id |
      | section1 | test objective       | Multiple Choice | 1             |

    And the following questions exist:
      | name     | qtype           | msg            | section_id |
      | S1Q1     | Multiple Choice | S1Q1 strong    | 1          |
      | S1Q2     | Multiple Choice | S1Q2 weak      | 1          |

    And the following presurveys exist:
      |   data            |    total        | course_id |
      |   PRESURVEY_DATA  | PRESURVEY_TOTAL |    1      |
      |   PRESURVEY_DATA  | PRESURVEY_TOTAL |    2      |
      |   PRESURVEY_DATA  | PRESURVEY_TOTAL |    3      |

    And the following postsurveys exist:
      | data            |   total           | course_id |
      | POSTSURVEY_DATA | POSTSURVEY_TOTAL  |    1      |
      | POSTSURVEY_DATA | POSTSURVEY_TOTAL  |    2      |
      | POSTSURVEY_DATA | POSTSRUVEY_TOTAL  |    3      |


    And the following courses exist:
      | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
      | 1         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |
      | 2         | Fall 2012   | 1             | 25              | 1            | 1             | 0      |
      | 2         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |

    And the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |
      | banana@gmail.com        | 12323d   | Banana        | ambassador | 1       | 1          |                   |                  |
      | apple@gmail.com         | 2isd82   | Apple         | ambassador | 1       | 1          |                   |                  |
      | grape@gmail.com         | 2isd82   | Grape         | ambassador | 0       | 1          | 1                 | Fall 2013        |
      | cherry@gmail.com        | 2isd82   | Cherry        | ambassador | 0       | 1          | 1                 | Fall 2013        |

    And the following users have courses:
      | user_id  | course_id  |
      | 2        | 1          |
      | 3        | 1          |
  }
end

Given /^the empty dataset is set up$/ do
  steps %Q{
    Given the following users exist:
      | email                   | password | name          | profile    | pending | college_id | pending_school_id | pending_semester |
      | admin@gmail.com         | 123f5    | Admin         | admin      | 1       | 1          |                   |                  |
  }
end
