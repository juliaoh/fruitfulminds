Feature: Generate a Report Summary

  As an Ambassador
  So that I can verify the correctness of report and add comments to it
  I want to view a summary of the report and add comments before generating a pdf version of the report

Background: Generate report based on survey results

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              |
    | john@gmail.com     | 12345    | john smith   | 1          |     2              |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | district |
    | school2 | Rowland | Rowland  | district |

  And the following curriculum exist:
    | name        |
    | curriculum1 |

  And the following MC sections exist:
    | name     | objective            | stype           | curriculum_id |
    | section1 | test objective       | Multiple Choice | 1             |

  And the following Efficacy sections exist:
    | name     | stype           | curriculum_id |  
    | section2 | Efficacy        | 1             |

  And the following questions exist:
    | name     | qtype           | msg1            | msg2         | section_id |
    | S1Q1     | Multiple Choice | S1Q1 strong     | S1Q1 weak    | 1          |
    | S1Q2     | Multiple Choice | S1Q2 strong     | S1Q2 weak    | 1          |
    | S2Q1     | Efficacy        | S2Q1 strong ef  | S2Q1 weak ef | 2          |
    | S2Q2     | Efficacy        | S2Q2 strong ef  | S2Q2 weak ef | 2          |

  And the following presurveys exist:
    | curriculum_id |   data            |    total        |
    | 1             |   PRESURVEY_DATA  | PRESURVEY_TOTAL |

  And the following postsurveys exist:
    | curriculum_id | data            |   total           |
    | 1             | POSTSURVEY_DATA | POSTSURVEY_TOTAL  |


  And the following courses exist:
    | school_id | semester    | curriculum_id | total_students  | presurvey_id | postsurvey_id |
    | 1         | Fall 2013   | 1             | 25              | 1            | 1             |

  And the following school_semesters exist:
    | school_id | name | year |
    | 1         | Fall | 2011 |

  And the following static content exists:
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary |
    | Intro Title | Intro Body   | Objective Title  | Sterngth-weakness Intro | Strength Intro | Weakness Intro | Eval Title | Summary |

  And I am logged in as amir
  And I am on the generate report page

  Scenario: See comment textbox on the report summary page
    Given I select "school1" from "school"
    And I press "Generate Report"
    Then I should see summary of the report with static contents
    And I should see "Ambassador Note"

  Scenario: Add comment to report
    Given I initiated the report generation for "school1"
    And I fill in "Ambassador Note" with "This is an ambassador comment"
    #And I press "Add Comments and Generate pdf"
    #Then I should be on the portal page
    #And I should see "PDF report was successfully generated"

  Scenario: Leave comment box empty and generate report
    Given I initiated the report generation for "school1"
    And I press "Add Comments and Generate pdf"
    Then I should be on the generate report page
    And I should see "Could not generate the PDF report"
