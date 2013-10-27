Feature: add food journal results

  As an ambassador
  So that I can see student's progress to see if they are improving
  I want to add a food journal

Background: results are to be added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |     1     |

  And the following schools exist:
    | name | county | city | 
    | "school1" | "Alameda" | "Berkeley" |

  And the following school_semesters exist:
    | school_id |   name   | year |
    |     1     |   Fall   | 2011 |

  And   I am logged in as amir
  And   I am on the portal page

Scenario: add new food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_1_fields_vegetable" with "37"
  And   I press "Save Changes"
  Then  I should see "Results failed to add. Incomplete or has invalid characters."

Scenario: add new food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_student_name" with "A Student"
  And   I press "Save Changes"
  Then  I should see "No results filled in."

Scenario: add new food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_week_1_fields_vegetable" with "37"
  And   I press "Save Changes"
  Then  I should see "Student Name cannot be empty."

Scenario: add new week 1 food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_1_fields_fruit" with "7"
  And   I fill in "food_journal_week_1_fields_vegetable" with "37"
  And   I fill in "food_journal_week_1_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_1_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Results successfully added."

Scenario: add new week 4 food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_num" with "4"
  And   I fill in "food_journal_week_1_fields_fruit" with "7"
  And   I fill in "food_journal_week_1_fields_vegetable" with "37"
  And   I fill in "food_journal_week_1_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_1_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Results successfully added."

Scenario: add new week 8 food journals to database
  When  I follow "Add Food Journal"
  Then  I should be on the Add New Food Journal page
  And   I fill in "food_journal_student_name" with "A Student"
  And   I fill in "food_journal_week_8_fields_fruit" with "7"
  And   I fill in "food_journal_week_8_fields_vegetable" with "37"
  And   I fill in "food_journal_week_8_fields_sugary_drink" with "73"
  And   I fill in "food_journal_week_8_fields_water" with "87"
  And   I press "Save Changes"
  Then  I should see "Results successfully added."
