Feature: Generate a Historical Report

  As an Admin
  So that I can look at the historical trends
  I want to view historical report based on attributes of report

Background: Generate historical report based on previously stored results

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following curriculum exist:
    | name        |
    | curriculum1 |


  And the following MC sections exist:
    | name     | objective            | stype           | curriculum_id |
    | section1 | test objective       | Multiple Choice | 1             |

  And the following questions exist:
    | name     | qtype           | msg            | section_id |
    | S1Q1     | Multiple Choice | S1Q1 weak      | 1          |
    | S1Q2     | Multiple Choice | S1Q2 strong    | 1          |
    | S2Q1     | Efficacy        | S2Q1 strong ef | 2          |
    | S2Q2     | Efficacy        | S2Q2 strong ef | 2          |

  And the following presurveys exist:
    |   data            |    total        | course_id |
    |   PRESURVEY_DATA  | PRESURVEY_TOTAL | 1         |

  And the following postsurveys exist:
    |   data            |    total        | course_id |
    |   PRESURVEY_DATA  | PRESURVEY_TOTAL | 1         |

  And the following courses exist:
    | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id | active |
    | 1         | Fall 2013   | 1             | 25              | 1            | 1             | true   |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              |
    | john@gmail.com     | 12345    | john smith   | 1          |     2              |

  And the following users have courses:
    | user_id  | course_id  |
    | 1        | 1          |
    
  And the following colleges exist:
    | name        |
    | UC Berkeley |

  And the following colleges have users:
    | college_id | user_id |
    | 1          | 1       |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | district |
    | school2 | Rowland | Rowland  | district |


  And the following static content exists:
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary |
    | Intro Title | Intro Body   | Objective Title  | Sterngth-weakness Intro | Strength Intro | Weakness Intro | Eval Title | Summary |

  And I am logged in as amir
  And I am on the historical report page

  Scenario: Show all historical results (Happy path)
    Given I press "select_all_schools_btn"
    And I press "select_all_semesters_btn"
    And I press "Generate Historical Reports"
    Then I should see "school1, Berkeley, Alameda" under "School"
    And I should see "Fall 2013" under "Semester"
    When I follow "Link"
    Then I should be on the reports page

  Scenario: Show based on time (Happy path)
    Given I select "Fall 2013" from "Times"
    And I select "All Schools" from "Schools"
    And I press "Generate Historical Reports"
    Then I should see "school1, Berkeley, Alameda" under "schools"
    And I should see "Fall 2013" under "date range"
    When I follow "Fall 2013"
    Then I should be on the reports page

  Scenario: Show generate historical report with no selections (sad path)
    When I press "Generate Historical Reports"
    Then I should be on the historical report page
    And I should see "Please select schools and time ranges"
