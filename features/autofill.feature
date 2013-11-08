Feature: Autofill data

  As a user
  So that I don't make mistakes choosing schools
  I want the location of the school to be autofilled

Background: users have been added to database

  Given the following profiles exist:
    | label      |
    | admin      |
    | ambassador |

  And the following schools exist:
    | name    | county  | city     | district |
    | school1 | Alameda | Berkeley | District |

