Feature: Admin can viwe cumulative reports
  As an Admin
  So that I can see all cumulative reports for all schools
  I want to see all cumulative reports for all schools

Background: Computer Cumulative Report based on Pre-Post-Surveys

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following school_semesters exist:
    | school_id | name | year |
    |     1     | Fall | 2011 |
  
  And the following users exist:
    | email              | password | name         | profile_id | school_semester_id |
    | amirk88@gmail.com  | 123f5    | amir khodaei | 1          |                    |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | district |
    | school2 | Rowland | Rowland  | district |

  And the following pre-results 1 exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | number_students |
    |    1    |     1     | 2  | 3  | 2  | 4  | 2  | 4  | 4  | 4  | 7  | 5  | 5  | 7  | 9  | 9  | 7 |

  And the following pre-results 2 exist:
    | school_semester_id | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |    1    |     1     | 3  | 3  | 2  | 4  | 2  | 7 |

  And the following post-results exist:
    | school_semester_id | section_1_1 | section_1_2 | section_2_1 | section_2_2 | section_2_3 | section_2_4 | section_3_1 | section_3_2 | section_3_3 | section_3_4 | section_3_5 | section_3_6 | section_4_1 | section_4_2 | section_4_3 | section_5_1 | section_5_2 | section_6_1 | section_6_2 | section_6_3 | section_6_4 | number_students |
    |    1    |     1     | 2  | 5  | 3  | 4  | 2  | 7  | 4  | 4  | 8  | 5  | 5  | 8  | 9  | 10  | 5  | 2 |    3    |     3     | 2  | 3  | 9 |

  And the following food journals exist:
    | student_name | school_semester_id | week_num | fruit | vegetable | sugary_drink | water |
    |   a name     |        1           |    1     |  34   |   53      |   61         |  43   |
    |   a name     |        1           |    3     |  34   |   33      |   32         |  43   |
    |   a name     |        1           |    8     |  34   |   53      |   53         |  24   |
    |  the name    |        1           |    1     |  34   |   26      |   63         |  24   |
    |  the name    |        1           |    5     |  41   |   39      |   63         |  24   |
    |  the name    |        1           |    8     |  34   |   68      |   53         |  24   |

  And I am logged in as "amirk88@gmail.com" with "123f5" as my password
  And I am on the portal page

  Scenario: See school1 in cumulative reports
    Given I follow "Cumulative Reports"
    Then I should be on the cumulative reports page
    And I should see "school1"
    And I should see "Alameda/district/Berkeley"
    And I should see "Fall/2011"
    And I should see a valid number as percentage
