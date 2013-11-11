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
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1     |
    | john@gmail.com     | 12345    | john smith   | 1          |     2     |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | district |
    | school2 | Rowland | Rowland  | district |

  And the following curriculum exist:
    | name        |
    | curriculum1 |

  And the following sections exist:
    | name     | objective      | stype           | curriculum_id |
    | section1 | test objective | Multiple Choice | 1             |
    | section2 |                | Efficacy        | 1             |

  And the following questions exist:
    | name     | qtype           | msg1            | msg2         | section_id |
    | S1Q1     | Multiple Choice | S1Q1 strong     | S1Q1 weak    | 1          |
    | S1Q2     | Multiple Choice | S1Q2 strong     | S1Q2 weak    | 1          |
    | S2Q1     | Efficacy        | S2Q1 strong ef  | S2Q1 weak ef | 2          |
    | S2Q2     | Efficacy        | S2Q2 strong ef  | S2Q2 weak ef | 2          |

  And the following courses exist:
    | school_id | semester    | curriculum_id | total_students  |
    | 1         | Fall 2013   | 1             | 25              |

  And the following pre-results exist:
    | course_id | 

  And the following pre-results 1 exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | number_students |
    |    1    |     1     | 2  | 3  | 2  | 4  | 2  | 4  | 4  | 4  | 7  | 5  | 5  | 7  | 9  | 9  | 18 |

  And the following pre-results 2 exist:
    | school_semester_id | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |    1    |     1     | 3  | 3  | 2  | 4  | 2  | 20 |

  And the following post-results exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    | 1                  | 1           | 2           | 5           | 3           | 4           | 2           | 7           | 4           | 4           | 8           | 5           | 5           | 8           | 9           | 10          | 5           | 2           |    3        |     3       | 2           | 3           | 9               |

  And the following efficacies exist:
    | postsurvey_id | part2_id | efficacy_1 | efficacy_2 | efficacy_3 | efficacy_4 | efficacy_5 | efficacy_6 | efficacy_7 | efficacy_8 | efficacy_9 | efficacy_10 | number_students |
    |      1   | nil | 3 | 4 | 4 | 6 | 5 | 4 |4 | 9 | 9| 4 | 22 |
    |      nil |  1  | 5 | 4 | 5 | 6 | 5 | 7 |4 | 10 | 9| 6 | 22 |

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
