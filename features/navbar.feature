Feature: Use Navbar Feature

  As an Administrator
  So that I can navigate through the rest of the site easily
  I want to have access to different sections of the site with a menu

Background: Generate curric, courses, login

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
    | name     | qtype           | msg1            | msg2         | section_id |
    | S1Q1     | Multiple Choice | S1Q1 strong     | S1Q1 weak    | 1          |
    | S1Q2     | Multiple Choice | S1Q2 strong     | S1Q2 weak    | 1          |
    | S2Q1     | Efficacy        | S2Q1 strong ef  | S2Q1 weak ef | 2          |
    | S2Q2     | Efficacy        | S2Q2 strong ef  | S2Q2 weak ef | 2          |

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
    | email              | password | name         | profile | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | admin      |     1              |
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


  And the following school_semesters exist:
    | school_id | name | year |
    | 1         | Fall | 2011 |

  And the following static content exists:
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary |
    | Intro Title | Intro Body   | Objective Title  | Sterngth-weakness Intro | Strength Intro | Weakness Intro | Eval Title | Summary |

  And I am logged in as amir

  @javascript
  Scenario: Use navbar dropdown to get to users page (happy path)
    When I click css id "#Users"
    When I click css id "#Show Users"
    Then I should be on the users page


  @javascript
  Scenario: Use navbar dropdown but stay on page (sad path)
    When I click css id "#Users"
    When I click css id "#Schools"
    Then I should be on the portal page
    Then I should not be on the users page

  @javascript
  Scenario: Use navbar dropdown to get to courses page (happy)
    When I click css id "#Courses"
    When I click css id "#Show Courses"
    Then I should be on the courses page

  @javascript
  Scenario: Use navbar to return to the home page (happy)
    When I click css id "#Logo"
    Then I should be on the portal page

