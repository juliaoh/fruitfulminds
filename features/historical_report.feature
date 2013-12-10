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
    | email              | password | name         | profile_id | school_semester_id | profile |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              | admin   |
    | john@gmail.com     | 12345    | john smith   | 1          |     2              | admin   |

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

  @javascript
  Scenario: Show all historical results (Happy path)
    Given I press "Select All Schools"
    And I press "Select All Semesters"
    And I press "Generate Historical Report"
    Then I should be on the historical results page

  Scenario: Show generate historical report with no selections (sad path)
    When I press "Generate Historical Report"
    Then I should be on the historical report page
    And I should see "Please select a school."
