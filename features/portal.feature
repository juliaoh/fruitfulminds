Feature: edit existing survey results

  As an ambassador
  So that I can edit survey reports
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1     |

  And the following pre-results 1 exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 |section_4_3 | number_students |
    |          1         |     3     |     9     |     6     |     7     |      9    |     6     | 4 | 7 | 5 | 4 | 5 | 6 | 8 | 4 | 4 | 5 | 32 |
    |          6         |     4     |     8     |     5     |     7     |      11   |     6     | 4 | 5 | 7 | 4 | 5 | 5 | 8 | 4 | 6 | 9 | 34 |
    |          2         |     3     |     8     |     4     |     7     |      9    |     6     | 4 | 9 | 5 | 5 | 5 | 5 | 10 | 4 | 6 | 5 | 11 |

  And the following pre-results 2 exist:
    | school_semester_id | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |         1          |      4      |      5      |      5      |      7      |      2      |      9      |       34        |
    |         2          |      6      |      5      |      8      |      7      |      3      |      9      |       22        |
    |         3          |      4      |      7      |      5      |      7      |      9      |     11      |       87        |

  And the following post-results exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 |section_4_3 | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |     1     | 2  | 3  | 2  | 4  | 2  | 4  | 4  | 4  | 7  | 5  | 5  | 7  | 9  | 9  | 5  | 2   | 5  | 7  | 9  | 9  | 6  | 4   | 23 |
    |     2     | 8  | 1  | 7  | 7  | 7  | 5  | 4  | 4  | 7  | 6  | 5  | 7  | 9  | 9  | 6  | 3   | 7  | 8  | 10  | 9  | 5  | 2   | 43 |
    |     2     | 3  | 2  | 2  | 2  | 2  | 6  | 4  | 6  | 8  | 5  | 6  | 9  | 3  | 1  | 5  | 2   | 5  | 7  | 10  | 11  | 5  | 4   | 11 |

  And the following efficacies exist:
    | postsurvey_id | part2_id | efficacy_1 | efficacy_2 | efficacy_3 | efficacy_4 | efficacy_5 | efficacy_6 | efficacy_7 | efficacy_8 | efficacy_9 | efficacy_10 | number_students |
    |      1   | nil | 3 | 4 | 4 | 6 | 5 | 4 |4 | 9 | 9| 4 | 22 |
    |     nil  |  1  | 5 | 4 | 5 | 6 | 5 | 7 |4 | 10 | 9| 6 | 22 |

  Given the following food journals exist:
    | student_name | school_semester_id | week_num | fruit | vegetable | sugary_drink | water |
    |   a name     |        1           |    1     |  43   |   53      |   61         |  43   |
    |   a name     |        1           |    3     |  34   |   33      |   32         |  43   |
    |   a name     |        1           |    8     |  34   |   53      |   53         |  24   |
    |  the name    |        1           |    1     |  34   |   26      |   63         |  24   |
    |  the name    |        1           |    5     |  41   |   39      |   63         |  24   |
    |  the name    |        1           |    8     |  34   |   68      |   53         |  24   |

  Given the following schools exist:
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And   I am logged in as amir
  And   I am on the portal page

Scenario: edit existing pre-survey 1 results
  When  I press "edit_pre_survey_part1_1"
  Then  I should be on the Edit Pre-Survey Results (Part 1) page for survey 1
  And   I fill in "presurvey_part1_section_1_1" with "adsfklj"
  And   I press "Save Changes"
  Then  I should see "Results failed to add. Incomplete or has invalid characters."

Scenario: edit existing pre-survey 2 results
  When  I press "edit_pre_survey_part2_1"
  Then  I should be on the Edit Pre-Survey Results (Part 2) page for survey 1
  And   I fill in "presurvey_part2_section_5_1" with "bad"
  And   I press "Save Changes"
  Then  I should see "Results failed to add. Incomplete or has invalid characters."

Scenario: edit existing post-survey results
  When  I press "edit_post_survey_1"
  Then  I should be on the Edit Postsurvey Results page for survey 1
  And   I fill in "postsurvey_section_1_1" with "ness"
  And   I press "Save Changes"
  Then  I should see "Results failed to add. Incomplete or has invalid characters."

Scenario: edit existing pre-survey 1 results
  When  I press "edit_pre_survey_part1_1"
  Then  I should be on the Edit Pre-Survey Results (Part 1) page for survey 1
  And   I fill in "presurvey_part1_number_students" with "7"
  And   I fill in "presurvey_part1_section_1_1" with "7"
  And   I fill in "presurvey_part1_section_1_2" with "7"
  And   I fill in "presurvey_part1_section_2_1" with "7"
  And   I fill in "presurvey_part1_section_2_2" with "7"
  And   I fill in "presurvey_part1_section_2_3" with "7"
  And   I fill in "presurvey_part1_section_2_4" with "7"
  And   I fill in "presurvey_part1_section_3_1" with "7"
  And   I fill in "presurvey_part1_section_3_2" with "7"
  And   I fill in "presurvey_part1_section_3_3" with "7"
  And   I fill in "presurvey_part1_section_3_4" with "7"
  And   I fill in "presurvey_part1_section_3_5" with "7"
  And   I fill in "presurvey_part1_section_3_6" with "7"
  And   I fill in "presurvey_part1_section_4_1" with "7"
  And   I fill in "presurvey_part1_section_4_2" with "7"
  And   I fill in "presurvey_part1_section_4_3" with "7"
  And   I press "Save Changes"
  Then  I should see "Survey updated successfully."

Scenario: edit existing pre-survey 2 results
  When  I press "edit_pre_survey_part2_1"
  Then  I should be on the Edit Pre-Survey Results (Part 2) page for survey 1
  And   I fill in "presurvey_part2_number_students" with "7"
  And   I fill in "presurvey_part2_section_5_1" with "7"
  And   I fill in "presurvey_part2_section_5_2" with "7"
  And   I fill in "presurvey_part2_section_6_1" with "7"
  And   I fill in "presurvey_part2_section_6_2" with "7"
  And   I fill in "presurvey_part2_section_6_3" with "7"
  And   I fill in "presurvey_part2_section_6_4" with "7"
  And   I fill in "efficacy_efficacy_1" with "7"
  And   I fill in "efficacy_efficacy_2" with "7"
  And   I fill in "efficacy_efficacy_3" with "7"
  And   I fill in "efficacy_efficacy_4" with "7"
  And   I fill in "efficacy_efficacy_5" with "7"
  And   I fill in "efficacy_efficacy_6" with "7"
  And   I fill in "efficacy_efficacy_7" with "7"
  And   I fill in "efficacy_efficacy_8" with "7"
  And   I fill in "efficacy_efficacy_9" with "7"
  And   I fill in "efficacy_efficacy_10" with "7"
  And   I press "Save Changes"
  Then  I should see "Survey updated successfully."

Scenario: edit existing post-survey results
  When  I press "edit_post_survey_1"
  Then  I should be on the Edit Postsurvey Results page for survey 1
  And   I fill in "postsurvey_number_students" with "7"
  And   I fill in "postsurvey_section_1_1" with "7"
  And   I fill in "postsurvey_section_1_2" with "7"
  And   I fill in "postsurvey_section_2_1" with "7"
  And   I fill in "postsurvey_section_2_2" with "7"
  And   I fill in "postsurvey_section_2_3" with "7"
  And   I fill in "postsurvey_section_2_4" with "7"
  And   I fill in "postsurvey_section_3_1" with "7"
  And   I fill in "postsurvey_section_3_2" with "7"
  And   I fill in "postsurvey_section_3_3" with "7"
  And   I fill in "postsurvey_section_3_4" with "7"
  And   I fill in "postsurvey_section_3_5" with "7"
  And   I fill in "postsurvey_section_3_6" with "7"
  And   I fill in "postsurvey_section_4_1" with "7"
  And   I fill in "postsurvey_section_4_2" with "7"
  And   I fill in "postsurvey_section_4_3" with "7"
  And   I fill in "postsurvey_section_5_1" with "7"
  And   I fill in "postsurvey_section_5_2" with "7"
  And   I fill in "postsurvey_section_6_1" with "7"
  And   I fill in "postsurvey_section_6_2" with "7"
  And   I fill in "postsurvey_section_6_3" with "7"
  And   I fill in "postsurvey_section_6_4" with "7"
  And   I fill in "efficacy_efficacy_1" with "7"
  And   I fill in "efficacy_efficacy_2" with "7"
  And   I fill in "efficacy_efficacy_3" with "7"
  And   I fill in "efficacy_efficacy_4" with "7"
  And   I fill in "efficacy_efficacy_5" with "7"
  And   I fill in "efficacy_efficacy_6" with "7"
  And   I fill in "efficacy_efficacy_7" with "7"
  And   I fill in "efficacy_efficacy_8" with "7"
  And   I fill in "efficacy_efficacy_9" with "7"
  And   I fill in "efficacy_efficacy_10" with "7"
  And   I press "Save Changes"
  Then  I should see "Survey updated successfully."

Scenario: edit food journals
  When  I press "edit_food_journal_1"
  Then  I should be on the Edit Food Journal page for journal 1
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_num" with "4"
  And   I fill in "food_journal_week_x_fields_fruit" with "7"
  And   I fill in "food_journal_week_x_fields_vegetable" with "37"
  And   I fill in "food_journal_week_x_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_x_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Results successfully updated."

Scenario: edit food journals
  When  I press "edit_food_journal_1"
  Then  I should be on the Edit Food Journal page for journal 1
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_8_fields_fruit" with "7"
  And   I fill in "food_journal_week_8_fields_vegetable" with "37"
  And   I fill in "food_journal_week_8_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_8_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Results successfully updated."

Scenario: edit food journals
  When  I press "edit_food_journal_1"
  Then  I should be on the Edit Food Journal page for journal 1
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_8_fields_fruit" with "7"
  And   I fill in "food_journal_week_8_fields_vegetable" with "37"
  And   I fill in "food_journal_week_8_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_8_fields_water" with "bad"
  And   I press "Save Changes"
  Then  I should see "Results failed to update. Incomplete or has invalid characters."

Scenario: edit food journals
  When  I press "edit_food_journal_1"
  Then  I should be on the Edit Food Journal page for journal 1
  And   I fill in "food_journal_student_name" with ""
  And   I fill in "food_journal_week_8_fields_fruit" with "7"
  And   I fill in "food_journal_week_8_fields_vegetable" with "37"
  And   I fill in "food_journal_week_8_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_8_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Student Name cannot be empty."
