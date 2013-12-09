Feature: Generate a Report Summary

  As an Ambassador
  So that I can verify the correctness of report and add comments to it
  I want to view a summary of the report and add comments before generating a pdf version of the report

Background: Generate report based on survey results

  And the following curriculum exist:
    | name        |
    | curriculum1 |

  And the following MC sections exist:
    | name     | objective            | stype           | curriculum_id |
    | section1 | test objective       | Multiple Choice | 1             |

  And the following Efficacy sections exist:
    | name     | stype    | curriculum_id |
    | section2 | Efficacy | 1             |

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
    | 1         | Fall 2013   | 1             | 25              | 1            | 1             | 1      |

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
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary | behavior_title | behavior_intro | increase_header | decrease_header | comp_header | summary_header | comp_intro |
    | Intro Title | Intro Body   | Objective Title  | Strength-weakness Intro | Strength Intro | Weakness Intro | Eval Title | Summary | Behavior Title | Behavior Intro | Increase Header | Decrease Header | Comp Header | Summary Header | Comp Intro |

  And I am logged in as amir
  And I am on the generate report page

  @javascript
  Scenario: See comment textbox on the report summary page
    Given I select "school1, Berkeley, Alameda, Fall 2013" from "course"
    And I press "Generate Report"
    And I should see "school1"
    And I should see "Intro Title"
    And I should see "Intro Body"
    And I should see "Objective Title"
    And I should see "Strength-weakness Intro"
    And I should see "Strength Intro"
    And I should see "Weakness Intro"
    And I should see "Eval Title"
    And I should see "Summary"
    And I should see "Behavior Title"
    And I should see "Behavior Intro"
    And I should see "Increase Header"
    And I should see "Decrease Header"
    And I should see "Comp Header"
    And I should see "Summary Header"
    And I should see "Ambassador Note"

  @javascript
  Scenario: Add comment to report and generate
    Given I initiated the report generation for "school1"
    And I fill in "Ambassador Note" with "This is an ambassador comment"
    And I press "Add Comments and Generate pdf"
    #Given I am on the portal page

  Scenario: Leave comment box empty and generate report
    Given I initiated the report generation for "school1"
    And I press "Add Comments and Generate pdf"
    Then I should be on the generate report page
    And I should see "Could not generate the PDF report"
