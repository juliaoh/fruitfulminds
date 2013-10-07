Feature: Generate a Textual Report

  As an Ambassador
  So that I can determine the Strengths and Weaknesses of the lessons in
  the curriculum taught
  I want to generate a textual report based on the results of pre/post
  surveys and the Ambassador's feedback

Background: Generate report based on survey results

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          | 1                  |
    | john@gmail.com     | 12345    | john smith   | 1          | 2                  |

  And the following schools exist:
    | name    | county  | city     |
    | school1 | Alameda | Berkeley |
    | school2 | Rowland | Rowland  |

  And the following pre-results 1 exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | number_students |
    |    1    |     1     | 2  | 3  | 2  | 4  | 2  | 4  | 4  | 4  | 7  | 5  | 5  | 7  | 9  | 9  | 7 |

  And the following pre-results 2 exist:
    | school_semester_id | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |    1    |     1     | 3  | 3  | 2  | 4  | 2  | 7 |

  And the following post-results exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |    1    |     1     | 2  | 5  | 3  | 4  | 2  | 7  | 4  | 4  | 8  | 5  | 5  | 8  | 9  | 10  | 5  | 2 |    3    |     3     | 2  | 3  | 9 |

  And the following efficacies exist:
    | postsurvey_id | part2_id | efficacy_1 | efficacy_2 | efficacy_3 | efficacy_4 | efficacy_5 | efficacy_6 | efficacy_7 | efficacy_8 | efficacy_9 | efficacy_10 | number_students |
    |      1   | nil | 3 | 4 | 4 | 6 | 5 | 4 |4 | 9 | 9| 4 | 22 |
    |     nil  |  1  | 5 | 4 | 5 | 6 | 5 | 7 |4 | 10 | 9| 6 | 22 |

  And the following food journals exist:
    | student_name | school_semester_id | week_num | fruit | vegetable | sugary_drink | water |
    |   a name     |        1           |    1     |  34   |   53      |   61         |  43   |
    |   a name     |        1           |    3     |  34   |   33      |   32         |  43   |
    |   a name     |        1           |    8     |  34   |   53      |   53         |  24   |
    |  the name    |        1           |    1     |  34   |   26      |   63         |  24   |
    |  the name    |        1           |    5     |  41   |   39      |   63         |  24   |
    |  the name    |        1           |    8     |  34   |   68      |   53         |  24   |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     |   Fall   | 2011 |
    |     2     |   Fall   | 2011 |

  And the following static content exists:
    | intro_title | introduction | objectives_title | strength_weakness_intro | strength_intro | weakness_intro | eval_title | summary | 
    | Intro to Fruitful Minds |   Fruitful Minds is a start up, non-profit organization providing nutrition education to youth at greatest risk for obesity and related illnesses.  The program recruits young people with a passion for health and education from local colleges and universities like UC Berkeley to develop curriculum and instruct children through classroom presentation, after school sports programs and summer camps.  While many nutrition programs exist today, Fruitful Minds is unique in its targeting of at-risk youth, customized approach and use of college students to deliver the program.  Fruitful Minds goal is to identify elementary schools, middle schools, and community centers where a nutrition education component is lacking and partner with existing sports, cooking or gardening programs to form a complete education focused on ending the escalating rate of obesity among at-risk youth.   | Fruitful Minds 7-Week Lesson Objectives |     Based on the pre- and post-curriculum surveys, as well as feedback from the ambassadors, we identified areas of strength and weaknesses. Below is a list of strengths and weaknesses of the class series:     |   Strengths:   | Weaknesses: |    Curriculum Evaluations     |  Based on our evaluation, we plan to spend more time developing the concepts that proved to be incompletely understood at the completion of the lesson series, and include more in-class activities that reinforce these learning objectives.  |

Scenario: Generate Report
  Given I am logged in as amir
  And I am on the generate report page
  And I select "school1" from "school"
  And I press "Generate Report"
  Then I should see "Fruitful Minds school1 Fall 2012 Report"
  And I should see "Intro to Fruitful Minds"
  And I should see "Fruitful Minds at school1"
  And I should see "Fruitful Minds 7-Week Lesson Objectives"
  And I should see "Curriculum Evaluations"
  And I should see "Strengths and Weaknesses of FM Lessons at school1"
  And I should see "Strengths:"
  And I should see "Weaknesses:"

Scenario: Generate Report Failure
  Given I am logged in as john
  And I am on the generate report page
  And I select "school2" from "school"
  And I press "Generate Report"
  And I should see "Not enough data available to generate a report for 'school2' school"
  And I should not see "Fruitful Minds school1 Fall 2012 Report"
  And I should not see "Intro to Fruitful Minds"
  And I should not see "Fruitful Minds at school1"
  And I should not see "Fruitful Minds 7-Week Lesson Objectives"
  And I should not see "Curriculum Evaluations"
  And I should not see "Strengths and Weaknesses of FM Lessons at school1"
  And I should not see "Strengths:"
  And I should not see "Weaknesses:"
  

