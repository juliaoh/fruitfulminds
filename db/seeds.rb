#encoding: utf-8

School.create!({:name => "Haven's Elementary", :county => "Alameda", :city => "Piedmont", :district => "PUSD"})
School.create!({:name => "Ascend School (Elementary)", :county => "Alameda", :city => "Oakland", :district => "OUSD"})
School.create!({:name => "Urban Promise Academy (Middle)", :county => "Alameda", :city => "Oakland", :district => "OUSD"})
School.create!({:name => "Rancho Romero Elementary", :county => "Contra Costa", :city => "Alamo", :district => "SRVUSD"})
School.create!({:name => "Berkeley Arts Magnet Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Emerson Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "King Middle", :county => "Alameda", :district => "BUSD", :city => "Berkeley"})
School.create!({:name => "LeConte Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Longfellow Middle", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Oxford Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Realm Charter Middle", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Thousand Oaks Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Washington Elementary", :county => "Alameda", :city => "Berkeley", :district => "BUSD"})
School.create!({:name => "Willard Middle", :county => "Alameda", :district => "BUSD", :city => "Berkeley"})

College.create!({:name=>'UC Berkeley'})
College.create!({:name=>'Vegetable College'})
College.create!({:name=>'College of the Fruits'})

Course.create!({:semester =>"Fall 2013", :total_students=>50, :school_id=>1, :curriculum_id=>2, :presurvey_id=>1, :postsurvey_id=>1, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>30, :school_id=>2, :curriculum_id=>1, :presurvey_id=>2, :postsurvey_id=>2, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>20, :school_id=>3, :curriculum_id=>1, :presurvey_id=>3, :postsurvey_id=>3, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>50, :school_id=>4, :curriculum_id=>1, :presurvey_id=>4, :postsurvey_id=>4, :active => true})

Curriculum.create!({:name=>'Test Curriculum 1', :published=>true})
Curriculum.create!({:name=>'Official Curriculum', :published=>true})
Section.create!({:name=>'Nutrition-Related Diseases', :stype=>'Multiple Choice', :objective=>'Discuss the relationship between nutrition and health; teach students that poor diet choices could lead to obesity, diabetes and heart diseases', :curriculum_id=>2})
Section.create!({:name=>'Food Groups', :stype=>'Multiple Choice', :objective=>'Teach students the importance of nutrition by breaking down food groups and basic nutrition terminologies.', :curriculum_id=>2})
Section.create!({:name=>'Nutrients', :stype=>'Multiple Choice', :objective=>'Discuss the metabolic functions of different nutrients; examine the quantities of fats, sugars, fiber and protein in various types of food.', :curriculum_id=>2})
Section.create!({:name=>'Nutrition Labeling', :stype=>'Multiple Choice', :objective=>'Teach students how to read and understand food labels to determine which foods are healthier than others.', :curriculum_id=>2})
Section.create!({:name=>'Food Advertising', :stype=>'Multiple Choice', :objective=>'Explore the role that advertisements play in influencing consumers’ choice of food; let students know how to make healthy food choices based on knowledge rather than misleading advertisements.', :curriculum_id=>2})
Section.create!({:name=>'Exercise, Energy, and Nutrition', :stype=>'Multiple Choice', :objective=>'Identify the connection between food and energy, and the role that physical activities play in overall health and longevity.', :curriculum_id=>2})
Section.create!({:name=>'Review Lesson', :stype=>'Multiple Choice', :objective=>'Review major concepts covered in the previous lessons. Students are given a chance to practice problem-solving in different scenarios given the knowledge they have in nutrition.', :curriculum_id=>2})

Question.create!({:name=>'Section 1 Question 1', :qtype=>'Multiple Choice', :section_id=> 1, :msg=>'Factors that may lead to type 2 diabetes'})
Question.create!({:name=>'Section 1 Question 2', :qtype=>'Multiple Choice', :section_id=> 1, :msg=>' Poor diet and lack of exercise increase risk for many diseases regardless of one’s body size'})

Question.create!({:name=>'Section 2 Question 1', :qtype=>'Multiple Choice', :section_id=> 2, :msg=>'The five different food groups included in USDA’s MyPlate'})
Question.create!({:name=>'Section 2 Question 2', :qtype=>'Multiple Choice', :section_id=> 2, :msg=>'All five food groups are important to help us achieve a balanced diet'})
Question.create!({:name=>'Section 2 Question 3', :qtype=>'Multiple Choice', :section_id=> 2, :msg=>'Frozen fruits and vegetables are as healthy as fresh fruits and vegetables'})
Question.create!({:name=>'Section 2 Question 4', :qtype=>'Multiple Choice', :section_id=> 2, :msg=>'The numbers of servings one needs for each food group on a daily basis'})

Question.create!({:name=>'Section 3 Question 1', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'The different nutrients and distinguish between food groups and nutrients'})
Question.create!({:name=>'Section 3 Question 2', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'How to distinguish between nutrients'})
Question.create!({:name=>'Section 3 Question 3', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'How to identify foods rich in fiber'})
Question.create!({:name=>'Section 3 Question 4', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'Some fats are healthier than others'})
Question.create!({:name=>'Section 3 Question 5', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'Vitamins have specific functions in the body'})
Question.create!({:name=>'Section 3 Question 6', :qtype=>'Multiple Choice', :section_id=> 3, :msg=>'Which nutrients tend to be beneficial, and which nutrients tend to be harmful when consumed in excess'})

Question.create!({:name=>'Section 4 Question 1', :qtype=>'Multiple Choice', :section_id=> 4, :msg=>'Calories are a measure of energy in food'})
Question.create!({:name=>'Section 4 Question 2', :qtype=>'Multiple Choice', :section_id=> 4, :msg=>'How to use the nutrition label to identify food products with too much salt'})
Question.create!({:name=>'Section 4 Question 3', :qtype=>'Multiple Choice', :section_id=> 4, :msg=>'How to calculate the numbers of servings in a food package'})

Question.create!({:name=>'Section 5 Question 1', :qtype=>'Multiple Choice', :section_id=> 5, :msg=>'The goals of food advertisements as well as the techniques that food companies use to promote their products'})
Question.create!({:name=>'Section 5 Question 2', :qtype=>'Multiple Choice', :section_id=> 5, :msg=>'How to distinguish between the advertising and factual components on a food package'})

Question.create!({:name=>'Section 6 Question 1', :qtype=>'Multiple Choice', :section_id=> 6, :msg=>'The benefits of physical activity'})
Question.create!({:name=>'Section 6 Question 2', :qtype=>'Multiple Choice', :section_id=> 6, :msg=>'The recommended amount of exercise'})
Question.create!({:name=>'Section 6 Question 3', :qtype=>'Multiple Choice', :section_id=> 6, :msg=>'The different types of physical activity'})
Question.create!({:name=>'Section 6 Question 4', :qtype=>'Multiple Choice', :section_id=> 6, :msg=>'Energy balance and the consequences of consuming excess energy'})

Section.create!({:name=>'Section 1',:stype=>'Multiple Choice',:objective=>'Section 1 objective', :curriculum_id=>1})
Section.create!({:name=>'Section 2', :stype=>'Efficacy', :curriculum_id=>1})
Question.create!({:name=>'S1Q1',:qtype=>'Multiple Choice',:msg=>'S1Q1 stronk', :section_id=>1})
Question.create!({:name=>'S1Q2',:qtype=>'Multiple Choice',:msg=>'S1Q2 weaaak', :section_id=>1})
Question.create!({:name=>'S2Q1',:qtype=>'Efficacy',:msg=>'S2Q1 stronk', :section_id=>2})


User.create!({:name => "admin account", :email => "admin@fruitfulminds.org", :password => "password", :profile => "admin", :pending => 1})
User.create!({:name => "another admin account", :email => "admin2@fruitfulminds.org", :password => "password", :profile => "admin", :pending => 1})
User.create!({:name => "fm ambassador account", :email => "user@fruitfulminds.org", :password => "password", :profile => "ambassador", :pending => 1, :college_id => 1, :course_ids => [1, 2, 3, 4]})
User.create!({:name => "another fm ambassador account", :email => "ambassador@fruitfulminds.org", :password => "password", :profile =>"ambassador", :pending => 1, :college_id => 2, :course_ids => [1, 2, 3, 4]})
User.create!({:name => "pending ambassador account", :email => "pendingambassador@fruitfulminds.org", :password => "password", :profile =>"ambassador", :pending => 0, :college_id => 3, :pending_school_id => 1, :pending_semester => "Fall 2013"})
User.create!({:name => "pending ambassador account 2", :email => "pendingambassador2@fruitfulminds.org", :password => "password", :profile =>"ambassador", :pending => 0, :college_id => 1, :pending_school_id => 2, :pending_semester => "Fall 2013"})
User.create!({:name => "pending ambassador account 3", :email => "pendingambassador3@fruitfulminds.org", :password => "password", :profile =>"ambassador", :pending => 0, :college_id => 2, :pending_school_id => 3, :pending_semester => "Fall 2013"})
User.create!({:name => "pending ambassador account 4", :email => "pendingambassador4@fruitfulminds.org", :password => "password", :profile =>"ambassador", :pending => 0, :college_id => 1, :pending_school_id => 4, :pending_semester => "Fall 2013"})


Presurvey.create!({:course_id => 1, :curriculum_id => 2, :data=>{3=>{1=>1, 2=>2, 3=>3}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Postsurvey.create!({:course_id => 1, :curriculum_id => 2, :data=>{3=>{1=>4, 2=>6, 3=>9}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Presurvey.create!({:course_id => 2, :curriculum_id => 1, :data=>{3=>{1=>1, 2=>2, 3=>3}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Postsurvey.create!({:course_id => 2, :curriculum_id => 1, :data=>{3=>{1=>4, 2=>6, 3=>9}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Presurvey.create!({:course_id => 3, :curriculum_id => 1, :data=>{3=>{1=>1, 2=>2, 3=>3}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Postsurvey.create!({:course_id => 3, :curriculum_id => 1, :data=>{3=>{1=>4, 2=>6, 3=>9}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Presurvey.create!({:course_id => 4, :curriculum_id => 1, :data=>{3=>{1=>1, 2=>2, 3=>3}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Postsurvey.create!({:course_id => 4, :curriculum_id => 1, :data=>{3=>{1=>4, 2=>6, 3=>9}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})

StaticContent.create!({
                   :intro_title => "Intro to Fruitful Minds",
                   :introduction => "Fruitful Minds is a start up, non-profit organization providing nutrition education to youth at greatest risk for obesity and related illnesses.  The program recruits young people with a passion for health and education from local colleges and universities like UC Berkeley to develop curriculum and instruct children through classroom presentation, after school sports programs and summer camps.  While many nutrition programs exist today, Fruitful Minds is unique in its targeting of at-risk youth, customized approach and use of college students to deliver the program.  The goal of Fruitful Minds is to identify elementary schools, middle schools, and community centers where a nutrition education component is lacking and partner with existing sports, cooking or gardening programs to form a complete education focused on ending the escalating rate of obesity among at-risk youth.",
                   :objectives_title => "Fruitful Minds 7-Week Lesson Objectives",
                   :strength_weakness_intro => "Based on the pre- and post-curriculum surveys, as well as feedback from the ambassadors, we identified areas of strength and weaknesses. Below is a list of strengths and weaknesses of the class series:",
                   :strength_intro => "Strengths:",
                   :weakness_intro => "Weaknesses:",
                   :comp_intro => "Competencies:",
                   :eval_title => "Curriculum Evaluations",
                   :summary => "Based on our evaluation, we plan to spend more time developing the concepts that proved to be incompletely understood at the completion of the lesson series, and include more in-class activities that reinforce these learning objectives.",
                   :behavior_title => "Behavior/Efficacy Section",
                   :behavior_intro => "In addition to examining improvements in curriculum knowledge, Fruitful Minds measures efficacy by seeing whether the lessons have been effective in increasing student ability to make changes in their own lives. Students rated their agreement with statements about their confidence in their ability to improve their diet and activity habits as part of the pre and post surveys.",
                   :increase_header => "There was an increase in agreement that students could",
                   :slight_increase_header => "There was a slight increase in agreement that students could",
                   :decrease_header => "There was a significant decrease in agreement that students could",
                   :slight_decrease_header => "There was a slight decrease in agreement that students could",
                   :comp_header => "Students were compentent prior to the curriculum in the following areas",
                   :summary_header => "Summary of findings:",

                  
                   
                  })
