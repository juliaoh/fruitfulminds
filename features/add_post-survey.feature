Feature: add post-survey results

  As an ambassador
  So that I can generate post-survey reports
  I want to have the data in an easy to access location

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1              |

  And the following schools exist:
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     | Fall | 2011 |

  And   I am logged in as amir
  And   I am on the portal page

Scenario: add new post-survey results to database
  When  I follow "Add Post-Survey Results"
  Then  I should be on the Add new post-survey results page
  And   I fill in "postsurvey_section_1_1" with "7"
  And   I press "Save Changes"
  Then  I should see "Results failed to add. Incomplete or has invalid characters."

Scenario: add new post-survey results to database
  When  I follow "Add Post-Survey Results"
  Then  I should be on the Add new post-survey results page
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
  Then  I should see "Results successfully added."
