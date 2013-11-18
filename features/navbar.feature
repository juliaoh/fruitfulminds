Feature: Generate a Report Summary

  As an Ambassador
  So that I can verify the correctness of report and add comments to it
  I want to view a summary of the report and add comments before generating a pdf version of the report

Background: Generate report based on survey results

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


  And the following school_semesters exist:
    | school_id | name | year |
    | 1         | Fall | 2011 |

  And the following static content exists:
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary |
    | Intro Title | Intro Body   | Objective Title  | Sterngth-weakness Intro | Strength Intro | Weakness Intro | Eval Title | Summary |

  And I am logged in as amir


  Scenario: Use navbar to get to users page
    When I press "users"



  Scenario: Use navbar to get to users page

  Scenario: Use navbar to get to courses page


  Scenario: Use navbar to get to courses page


  Scenario: Use navbar to get to schools page

  Scenario: Use navbar to get to schools page