# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

Course.create!({:semester =>"Fall 2013", :total_students=>25, :school_id=>1, :curriculum_id=>1, :presurvey_id=>1, :postsurvey_id=>1, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>30, :school_id=>2, :curriculum_id=>1, :presurvey_id=>2, :postsurvey_id=>2, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>20, :school_id=>3, :curriculum_id=>1, :presurvey_id=>3, :postsurvey_id=>3, :active => true})
Course.create!({:semester =>"Fall 2013", :total_students=>50, :school_id=>4, :curriculum_id=>1, :presurvey_id=>4, :postsurvey_id=>4, :active => true})

Curriculum.create!({:name=>'Test Curriculum 1', :published=>true})
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


Presurvey.create!({:course_id => 1, :curriculum_id => 1, :data=>{3=>{1=>1, 2=>2, 3=>3}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
Postsurvey.create!({:course_id => 1, :curriculum_id => 1, :data=>{3=>{1=>4, 2=>6, 3=>9}, 4=>{1=>4, 2=>5, 3=>6}}, :total=>{3=>25}})
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
                   :agree_1 => "Prepare a healthy snack to eat at home",
                   :agree_2 => "Prepare a healthy snack to take and eat at school",
                   :agree_3 => "Eat at least 1 fruit at home at least 4 times a week",
                   :agree_4 => "Eat at least 1 vegetable at home at least 4 times a week",
                   :agree_5 => "Feel comfortable talking with parent and/or guardian about food",
                   :agree_6 => "Feel comfortable asking parent and/or guardian to buy junk food",
                   :agree_7 => "Feel comfortable asking parent and/or guardian to buy healthy snacks",
                   :agree_8 => "Read a nutrition label to figure out whether or not a food item is as healthy as the advertisement says",
                   :agree_9 => "Want to buy and eat junk food after watching an advertisement",
                   :agree_10 => "Ignore an advertisement for junk food after watching it",
                   :increase_header => "There was an increase in agreement that students could",
                   :slight_increase_header => "There was a slight increase in agreement that students could",
                   :decrease_header => "There was a significant decrease in agreement that students could",
                   :slight_decrease_header => "There was a slight decrease in agreement that students could",
                   :comp_header => "Students were compentent prior to the curriculum in the following areas",
                   :summary_header => "Summary of findings:",

                   :increase_1_2 => "Healthy snack demonstrations were found to be effective because students learned how they could prepare healthy snacks on their own to eat at home. They also felt that they could make the snacks and bring them to school to eat.",
                   :increase_1 => "Healthy snack demonstrations were found to be effective because students learned how they could prepare healthy snacks on their own to eat at home.",
                   :increase_2 => "Healthy snack demonstrations were found to be effective in increasing confidence that students could prepare healthy snacks to bring to school.",
                   :increase_3_4 => "The lesson series increased student confidence that they could consume at least 1 vegetable and 1 fruit 4 times a week.",
                   :increase_3 => "The lesson series increased student confidence that they could consume at least 1 vegetable 4 times a week.",
                   :increase_4 => "If 4 only: The lesson series increased student confidence that they could consume at least 1 fruit 4 times a week.",
                   :increase_5_6_7 => "Fruitful Minds lessons were effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable talking to their parents and/or guardians about food in general and also felt they could ask for either junk food or healthy snacks when grocery shopping.",
                   :increase_5_6 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable talking to their parents and/or guardians about food in general and also felt they could ask for junk food when grocery shopping.",
                   :increase_5_7 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable talking to their parents and/or guardians about food in general and also felt they could ask for healthy snacks when grocery shopping.",
                   :increase_6_7 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable that they could ask for either junk food or healthy snacks when grocery shopping.",
                   :increase_5 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable talking to their parenst and/or guardians about food in general.",
                   :increase_6 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable asking their parents and/or guardians for junk food when grocery shopping.",
                   :increase_7 => "Fruitful Minds lessons were partially effective in increasing communication between students and parents and/or guardians about food. Students felt more comfortable asking their parents and/or guardians for healthy snacks when grocery shopping.",
                   :increase_8_9_10 => "Nutrition label lessons were effective for students because they felt more confident that they could use the nutrition label to verify health claims from ads. More students agreed that they wanted to eat and buy junk food after watching advertisements; however, they also felt more confident that they could ultimately ignore the advertisements.",
                   :increase_8_9 => "Nutrition label lessons were effective for students because they felt more confident that they could use the nutrition label to verify health claims from ads. However, more students agreed that they wanted to eat and buy junk food after watching advertisements.",
                   :increase_8_10 => "Lessons about media and nutrition labeling were effective for students. They felt more confident that they could use the nutrition label to verify health claims from ads. They also felt that they could ignore advertisements for junk food.",
                   :increase_9_10 => "Lessons about media were partially effective for students. More students agreed that they wanted to eat and buy junk food after watching advertisements; however, they also felt more confident that they could ultimately ignore the advertisements.",
                   :increase_8 => "Nutrition label lessons were effective for students because they felt more confident that they could use the nutrition label to verify health claims from ads.",
                   :increase_9 => "Unfortunately, more students agreed that they wanted to eat and buy junk food after watching advertisements.",
                   :increase_10 => "Lessons about media were effective for students, who were more confident that they could ignore advertisements for junk food.",

                   :decrease_1_2 => "Healthy snack demonstrations were found to be ineffective because students did not learn how they could prepare healthy snacks on their own to eat at home. They also did not feel that they could make the snacks and bring them to school to eat.",
                   :decrease_1 => "Students felt less confident that they could prepare healthy snacks to eat at home.",
                   :decrease_2 => "Students felt less confident that they could prepare healthy snacks to bring to school.",
                   :decrease_3_4 => "The lesson series decreased student confidence that they could consume at least 1 vegetable and 1 fruit 4 times a week.",
                   :decrease_3 => "There was decreased student confidence that they could consume at least 1 vegetable 4 times a week.",
                   :decrease_4 => "There was decreased student confidence that they could consume at least 1 fruit 4 times a week.",
                   :decrease_5_6_7 => "Students became less confident communicating with their parents and/or guardians about food. Students felt less comfortable talking to their parents and/or guardians about food in general and also felt they could not ask for junk food or healthy snacks when grocery shopping.",
                   :decrease_5_6 => "Students felt less comfortable talking to their parents and/or guardians about food in general and also felt they could not ask for junk food when grocery shopping.",
                   :decrease_5_7 => "Students felt less comfortable talking to their parents and/or guardians about food in general and also felt they could not ask for healthy snacks when grocery shopping.",
                   :decrease_6_7 => "Students felt less comfortable asking parents and/or guardians for junk food or healthy snacks when grocery shopping.",
                   :decrease_5 => "Students felt less comfortable talking to their parents and/or guardians about food in general.",
                   :decrease_6 => "Students felt less comfortable asking parents and/or guardians for junk food when grocery shopping.",
                   :decrease_7 => "Students felt less comfortable asking parents and/or guardians for healthy snacks when grocery shopping.",
                   :decrease_8_9_10 => "Nutrition label lessons were not effective for students because they felt less confident that they could use the nutrition label to verify health claims from ads. Students felt less confident that they could ignore advertisements for junk food but they also felt that they would not feel like buying or eating the advertised food.",
                   :decrease_8_9 => "Nutrition label lessons were not effective for students because they felt less confident that they could use the nutrition label to verify health claims from ads. However, there was less agreement that students would want to eat and buy junk food after watching advertisements.",
                   :decrease_8_10 => "Lessons about media and nutrition labeling were not effective for students. They felt less confident that they could use the nutrition label to verify health claims from ads and did not feel that they could ignore advertisements for junk food.",
                   :decrease_9_10 => "Lessons about media were partially effective for students. Students felt less confident that they could ignore advertisements for junk food but they also felt that they would not feel like buying or eating the advertised food.",
                   :decrease_8 => "Nutrition label lessons were not effective for students because they felt less confident that they could use the nutrition label to verify health claims from ads.",
                   :decrease_9 => "There was less agreement that students would want to eat and buy junk food after watching advertisements.",
                   :decrease_10 => "Lessons about media were not effective for students. Students were less confident that they could ignore advertisements for junk food.",

                   
                  })
