class ReportsController < ApplicationController
  def new
    @schools = @current_user.schools
  end

  def create
    @school_semester = @current_user.school_semester
    @schools = @current_user.schools
    @school = School.find_by_id(params[:school])

    if @schools.include?(@school)
      if @school.has_all_report_data
        @report = Report.create!(:school_semester_id => @school_semester.id)
        @report_created = true

        #static content
        @static_contents = StaticContent.first
        #populate_objectives

        #dynamic content
        @ambassadors = ""
        @school.users.each do |user|
          @ambassadors += user.name + ", "
        end
        
        @main_title = "Fruitful Minds #{@school.name} Fall 2012 Report"
        @school_intro_title = "Fruitful Minds at #{@school.name}"
        @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school.name} during #{@school_semester.name} #{@school_semester.year}" 
        @school_intro_second = "    #{@school.users.size} students from UC Berkeley #{@ambassadors} were selected as Fruitful Minds ambassadors"    
        @school_intro_third = "    During each 50-minute lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
        @eval_intro_first = "Prior to the 7-week curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
        @efficacy = calculate_efficacy
        @eval_intro_second = "On average, students have shown a #{@efficacy}% improvement after going through seven weeks of classes." 
        @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@school_semester.presurvey_part1s[0].number_students} took the pre-curriculum survey, and #{@school_semester.postsurveys[0].number_students} students took the post-curriculum surveys."
        @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school.name}"
        generate_strengths
        generate_weaknesses
        @objectives = {
                  "1. Nutrition-related Diseases" => "Discuss the relationship between nutrition and health; teach     students that poor diet choices could lead to obesity, diabetes and heart diseases.",
                  "2. Food Groups" => "Teach students the importance of nutrition by breaking down food groups and basic nutrition terminologies.",
                  "3. Nutrients" => "Discuss the metabolic functions of different nutrients; examine the quantities of fats, sugars, fiber and protein in various types of food.",
                  "4. Nutrition Labeling" => "Teach students how to read and understand food labels to determine which foods are healthier than others. ",
                  "5. Food Advertising " => "Explore the role that advertisements play in influencing consumers\' choice of food; let students know how to make healthy food choices based on knowledge rather than misleading advertisements.",
                  "6. Exercise, Energy and Nutrition" => "Identify the connection between food and energy, and the role that physical activities play in overall health and longevity.",
                   "7. Review lesson" => "Review major concepts covered in the previous lessons. Students are given a chance to practice problem-solving in different scenarios given the knowledge they have in nutrition."  }
        @improvement_intro = "#{@ps_part1.number_students} students took the pre-efficacy survey part 1, #{@ps_part2.number_students} students took the pre-efficacy survey part 2 and #{@ps.number_students} students took the post-efficacy survey. These were not necessarily the same students. However, on average, students showed significant increases in their agreement that they could"
        generate_mapping
        generate_fj_data                   
        generate_graph
        show
        @ambassadorNoteTitle = "Ambassador Notes: "
        @graphdata1 = [[(@topicPre[1].round 2)*100, (@topicPre[2].round 2)*100, (@topicPre[3].round 2)*100, (@topicPre[4].round 2)*100, (@topicPre[5].round 2)*100, (@topicPre[6].round 2)*100], [(@topicPost[1].round 2)*100, (@topicPost[2].round 2)*100, (@topicPost[3].round 2)*100, (@topicPost[4].round 2)*100, (@topicPost[5].round 2)*100, (@topicPost[6].round 2)*100]]
        @graphdata2 = [[(@efficacy_pre.round 2)*100],[(@efficacy_post.round 2)*100]]
        generate_graphs(@graphdata1, @graphdata2)
        generate_efficacy_graphs(@meanPreList, @meanPostList)

                                    
        flash[:notice] = "Report generated successfully for #{School.find(params[:school]).name}"

      else
        flash[:warning] = "Not enough data available to generate a report for '#{@school.name}' school" # to createdoes not have Presurvey Part 1 and 2 or Postsurvey"
        redirect_to new_report_path
      end
    else
      flash[:warning] = "Current user only has access to #{@current_user.school.name}"
      redirect_to new_report_path
    end
  end
  
  
  def generate_graphs(data1, data2)
      
      @axis1 = "Nutrition Related Diseases"
      @axis2 = 'Food Groups'
      @axis3 = 'Nutrients'
      @axis4 = 'Nutrition Labeling'
      @axis5 = 'Food Advertisments'
      @axis6 = 'Physical Activities'
      
      @max1 = data1[0].compact.max
      @max2 = data1[1].compact.max
      @max3 = data2[0].compact.max
      @max4 = data2[1].compact.max
      
      if @max1 > @max2
        @max = @max1
      else
        @max = @max2
      end

      if @max3 > @max4
        @combined_max = @max3
      else
        @combined_max = @max4
      end


      @nutrition_chart = Gchart.bar(:size => '1000x300', 
                                :title => "Average Survey Score in Six Nutrition Topics",
                                :legend => ['Pre-curriculum Results', 'Post-curriculum Results'],
                                :bar_colors => '3399CC,99CCFF',
                                :data => data1,
                                :bar_width_and_spacing => '35,0,50',
                                :axis_with_labels => 'x,y',
                                #:axis_labels => ['Nutrition Related Diseases(2 Questions)|Food Groups(4 Questions)|Nutrients(6 Questions)|Nutrition Labeling(3 Questions)|Food Advertisments(2 Questions)|Physical Activities(5 Questions)'],
                                :axis_labels => ["#{@axis1}|#{@axis2}|#{@axis3}|#{@axis4}|#{@axis5}|#{@axis6}"],
                                :stacked => false,
                                :axis_range => [nil, [0,@max,10]]
                                ) 
                                

                                
      @combined_chart = Gchart.bar(:size => '1000x300', 
                              :title => "Overall Combined Scores(%)",
                              :legend => ['Pre-curriculum Results', 'Post-curriculum Results'],
                              :bar_colors => 'FF3333,990000',
                              :data => data2,
                              :bar_width_and_spacing => '50,25,25',
                              :axis_with_labels => 'y',
                              :stacked => false,
                              :axis_range => [[0,@combined_max,10]]
                            )  
  end


  def generate_pdf
    @report = Report.find_by_id(params[:report][:id])
    @school = School.find_by_id(params[:school][:id])

    if not params[:amb_note].blank?
      #puts ">> #{params[:amb_note]} <<"
      #@reportNote = params[:amb_note]
      session[:amb_note] = params[:amb_note]
      #puts @reportNote
      if @report.save
        # logic for generating the pdf
        # save the pdf in database
        # generate a link for downloading the pdf
        show

        redirect_to "/reports/#{@fileName}"
        return
      end
    end

    flash[:warning] = "Could not generate the PDF report"
    redirect_to new_report_path and return
  end
  
    
  def show

    @reportNote = session[:amb_note]

    schoolName = @school.name
    schoolName.gsub! /\s+/, '_'
    schoolName = schoolName.downcase
    @fileName = "#{schoolName}_report.pdf"

    @school_semester = @current_user.school_semester
    schoolName.gsub!(/_/, ' ')    
    @school.name.gsub!(/_/, ' ')

    @main_title = "Fruitful Minds #{@school.name} Fall 2012 Report"
    @school_intro_title = "Fruitful Minds at #{@school.name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school.name} during #{@school_semester.name} #{@school_semester.year}" 
    @school_intro_second = "    #{@school.users.size} students from UC Berkeley #{@ambassadors} were selected as Fruitful Minds ambassadors"    
    @school_intro_third = "    During each 50-minute lesson, class facilitators delivered the cirriculum material through lectures, games, and various interactive activities."
    @eval_intro_first = "Prior to the 7-week curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
    @efficacy = calculate_efficacy
    @eval_intro_second = "On average, students have shown a #{@efficacy}% improvement after going through seven weeks of classes." 
    @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@ps_part1.number_students} students took the pre-curriculum survey part 1, #{@ps_part2.number_students} students took the pre-efficacy survey part 2, and #{@ps.number_students} students took the post-curriculum surveys."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school.name}"
    @static_contents = StaticContent.first
    generate_strengths
    generate_weaknesses
    @ambassadorNoteTitle = "Ambassador Notes: "
    @improvement_intro = "#{@ps_part1.number_students} students took the pre-efficacy survey part 1, #{@ps_part2.number_students} students took the pre-efficacy survey part 2, and #{@ps.number_students} students took the post-efficacy survey. These were not necessarily the same students. However, on average, students showed significant increases in their agreement that they could"
    generate_mapping

    @objectives = {
                  "1. Nutrition-related Diseases" => "Discuss the relationship between nutrition and health; teach     students that poor diet choices could lead to obesity, diabetes and heart diseases.",
                  "2. Food Groups" => "Teach students the importance of nutrition by breaking down food groups and basic nutrition terminologies.",
                  "3. Nutrients" => "Discuss the metabolic functions of different nutrients; examine the quantities of fats, sugars, fiber and protein in various types of food.",
                  "4. Nutrition Labeling" => "Teach students how to read and understand food labels to determine which foods are healthier than others. ",
                  "5. Food Advertising " => "Explore the role that advertisements play in influencing consumers\' choice of food; let students know how to make healthy food choices based on knowledge rather than misleading advertisements.",
                  "6. Exercise, Energy and Nutrition" => "Identify the connection between food and energy, and the role that physical activities play in overall health and longevity.",
                   "7. Review lesson" => "Review major concepts covered in the previous lessons. Students are given a chance to practice problem-solving in different scenarios given the knowledge they have in nutrition."  }
    
    #@objectivesTable = [["Lessons", "Objectives"]]
    
    @objectivesTable = @objectives.map do |item1, item2|
      [
      item1, item2
      ]
    end
    
    generate_graph

    @graphdata1 = [[@topicPre[1], @topicPre[2], @topicPre[3], @topicPre[4], @topicPre[5], @topicPre[6]], [@topicPost[1], @topicPost[2], @topicPost[3], @topicPost[4], @topicPost[5], @topicPost[6]]]
    @graphdata2 = [[@efficacy_pre],[@efficacy_post]]
    generate_pdf_graphs(@graphdata1, @graphdata2)
    generate_efficacy_pdf_graphs(@meanPreList, @meanPostList)
    generate_fj_data 
                      

    
    
  end
  
  def generate_pdf_graphs(data1, data2)
      
      @axis1 = "Nutri. Rel. Diseases"
      @axis2 = 'Food Groups'
      @axis3 = 'Nutrients'
      @axis4 = 'Nutri. Labeling'
      @axis5 = 'Food Ads'
      @axis6 = 'Phys. Activities'
      
      @max1 = data1[0].compact.max
      @max2 = data1[1].compact.max
      @max3 = data2[0].compact.max
      @max4 = data2[1].compact.max
      
      if @max1 > @max2
        @max = @max1
      else
        @max = @max2
      end

      if @max3 > @max4
        @combined_max = @max3
      else
        @combined_max = @max4
      end

      @nutrition_chart = Gchart.bar(:size => '1000x300', 
                                :title => "Average Survey Score in Six Nutrition Topics",
                                :legend => ['Pre', 'Post'],
                                :bar_colors => '3399CC,99CCFF',
                                :data => data1,
                                :bar_width_and_spacing => '30,0,23',
                                :axis_with_labels => 'x,y',
                                #:axis_labels => ['Nutrition Related Diseases(2 Questions)|Food Groups(4 Questions)|Nutrients(6 Questions)|Nutrition Labeling(3 Questions)|Food Advertisments(2 Questions)|Physical Activities(5 Questions)'],
                                :axis_labels => ["#{@axis1}|#{@axis2}|#{@axis3}|#{@axis4}|#{@axis5}|#{@axis6}"],
                                :stacked => false,
                                :axis_range => [nil, [0,@max,10]]
                                ) 
                                

                                
      @combined_chart = Gchart.bar(:size => '1000x300', 
                              :title => "Overall Combined Scores(%)",
                              :legend => ['Pre-curriculum Results', 'Post-curriculum Results'],
                              :bar_colors => 'FF3333,990000',
                              :data => data2,
                              :bar_width_and_spacing => '50,25,25',
                              :axis_with_labels => 'y',
                              :stacked => false,
                              :axis_range => [[0,@combined_max,10]]
                            )  
  end
  
  def generate_efficacy_graphs(data1, data2)
    
    @axis1 = "Prepare healthy snacks at home"
    @axis2 = 'Prepare healthy snacks for school'
    @axis3 = 'Eat 1 fruit 4x a week'
    @axis4 = 'Eat 1 vegetable 4x a week'
    @axis5 = 'Talk about food to parent'
    @axis6 = 'Ask parent for junk food'
    @axis7 = 'Ask parent for healthy snacks'
    @axis8 = 'Food is healthy from nutrition label'
    @axis9 = 'Buyjunk food when ads watched'
    @axis10 = 'Can ignore ad for junk food'
    preData = []
    postData = []
    finalData = []
    
    for elem in data1
      elem = elem * 100
      elem = elem.round
      preData << elem
    end
    
    for elem in data2
      elem = elem * 100
      elem = elem.round
      postData << elem
    end
    
    finalData = [preData,postData]
    puts finalData
    
    @max1 = preData.compact.max
    @max2 = postData.compact.max
    

    
    if @max1 > @max2
      @max = @max1
    else 
      @max = @max2
    end

    


    @efficacy_chart = Gchart.bar(:size => '700x400', 
                              :title => "Efficacy Survey Results - Agreement(%)",
                              :legend => ['Pre-curriculum Results', 'Post-curriculum Results'],
                              :bar_colors => '990000,3399CC',
                              :data => finalData,
                              :bar_width_and_spacing => '13,0,10',
                              :axis_with_labels => 'y,x',
                              #:axis_labels => ['Nutrition Related Diseases(2 Questions)|Food Groups(4 Questions)|Nutrients(6 Questions)|Nutrition Labeling(3 Questions)|Food Advertisments(2 Questions)|Physical Activities(5 Questions)'],
                              :axis_labels => ["#{@axis1}|#{@axis2}|#{@axis3}|#{@axis4}|#{@axis5}|#{@axis6}|#{@axis7}|#{@axis8}|#{@axis9}|#{@axis10}"],
                              :stacked => false,
                              :axis_range => [nil, [0,@max,10]],
                              :orientation => 'horizontal'
                              ) 
                              
 
  end
  
  def generate_efficacy_pdf_graphs(data1, data2)
    
    @axis1 = "Prepare healthy snacks at home"
    @axis2 = 'Prepare healthy snacks for school'
    @axis3 = 'Eat 1 fruit 4x a week'
    @axis4 = 'Eat 1 vegetable 4x a week'
    @axis5 = 'Talk about food to parent'
    @axis6 = 'Ask parent for junk food'
    @axis7 = 'Ask parent for healthy snacks'
    @axis8 = 'Healthy food from nutrition label'
    @axis9 = 'Buy junk food when ads watched'
    @axis10 = 'Can ignore ad for junk food'
    preData = []
    postData = []
    finalData = []
    
    for elem in data1
      elem = elem * 100
      elem = elem.round
      preData << elem
    end
    
    for elem in data2
      elem = elem * 100
      elem = elem.round
      postData << elem
    end
    
    finalData = [preData,postData]
    puts finalData
    
    @max1 = preData.compact.max
    @max2 = postData.compact.max
    

    
    if @max1 > @max2
      @max = @max1
    else 
      @max = @max2
    end

    


    @efficacy_chart = Gchart.bar(:size => '500x400', 
                              :title => "Efficacy Survey Results - Agreement(%)",
                              :legend => ['Pre', 'Post'],
                              :bar_colors => '990000,3399CC',
                              :data => finalData,
                              :bar_width_and_spacing => '13,0,10',
                              :axis_with_labels => 'y,x',
                              #:axis_labels => ['Nutrition Related Diseases(2 Questions)|Food Groups(4 Questions)|Nutrients(6 Questions)|Nutrition Labeling(3 Questions)|Food Advertisments(2 Questions)|Physical Activities(5 Questions)'],
                              :axis_labels => ["#{@axis1}|#{@axis2}|#{@axis3}|#{@axis4}|#{@axis5}|#{@axis6}|#{@axis7}|#{@axis8}|#{@axis9}|#{@axis10}"],
                              :stacked => false,
                              :axis_range => [nil, [0,@max,10]],
                              :orientation => 'horizontal'
                              ) 
                              
 
  end
  
  def generate_mapping
    @verdicts = {}
    @T = { 1 => 6.314, 2 => 2.920, 3 => 2.353, 4 => 2.132, 5 => 2.015, 
           6 => 1.943, 7 => 1.895, 8 => 1.860, 9 => 1.833, 10 => 1.812,
           11 => 1.796, 12 => 1.782, 13 => 1.771, 14 => 1.761, 15 => 1.753, 
           16 => 1.746, 17 => 1.740, 18 => 1.734, 19 => 1.729, 20 => 1.725,
           21 => 1.721, 22 => 1.717, 23 => 1.714, 24 => 1.711, 25 => 1.708,
           26 => 1.706, 27 => 1.703, 28 => 1.701, 29 => 1.699, 30 => 1.697,
           40 => 1.684, 60 => 1.671, 80 => 1.664, 100 => 1.660, 1000 => 1.646 }

    @sig_increase = []
    @sig_decrease = []
    @slight_increase = []
    @slight_decrease = []
    @meanPreList = []
    @meanPostList = []

    10.times do |i|
      index = i + 1
      numAgreesPre = @ps_part2.efficacy[0]["efficacy_#{index}"]
      numStudentsPre = @ps_part2.number_students
      meanPre = numAgreesPre/(numStudentsPre*1.0)
      @meanPreList << meanPre
      diffSquareSumPre = (1.0 - meanPre)*(1.0 - meanPre)*numAgreesPre
      preSD = Math.sqrt(diffSquareSumPre/(numStudentsPre-1.0))

      numAgreesPost = @ps.efficacy[0]["efficacy_#{index}"]
      numStudentsPost = @ps.number_students
      meanPost = numAgreesPost/(numStudentsPost*1.0)
      @meanPostList << meanPost

      diffSquareSumPost = (1.0 - meanPost)*(1.0 - meanPost)*numAgreesPost
      postSD = Math.sqrt(diffSquareSumPost/(numStudentsPost-1.0))

      numerator = (meanPost-meanPre).abs
      denom = (Math.sqrt((preSD)*(preSD)/numStudentsPre + (postSD)*(postSD)/numStudentsPost))
      t = (meanPost-meanPre).abs/(Math.sqrt((preSD)*(preSD)/numStudentsPre + (postSD)*(postSD)/numStudentsPost))
      df = [ numStudentsPre - 1, numStudentsPost - 1 ].min
      if df > 30 and df < 40
        df = 30
      elsif df > 40 and df < 60
        df = 40
      elsif df > 60 and df < 80
        df = 60
      elsif df > 80 and df < 100
        df = 80
      elsif df > 100 and df < 1000
        df = 100
      elsif df > 1000
        df = 1000
      end

      verdict = @T[df] < t
      @verdicts[index] = verdict      

      if verdict
        if meanPost > meanPre
          @sig_increase << @static_contents["agree_#{index}"]
          @verdicts[index] = 1
        else
          @sig_decrease << @static_contents["agree_#{index}"]
          @verdicts[index] = -1
        end
      else
        @verdicts[index] = 0
        if meanPost > meanPre
          @slight_increase << @static_contents["agree_#{index}"]
        elsif meanPre > meanPost
          @slight_decrease << @static_contents["agree_#{index}"] 
        end
      end
    end


    @sig_inc_map = []

    if @verdicts[1] == 1
      if @verdicts[2] == 1
        @sig_inc_map << @static_contents["increase_1_2"]
      else
        @sig_inc_map << @static_contents["increase_1"]
      end
    elsif @verdicts[2] == 1
      @sig_inc_map << @static_contents["increase_2"]
    end

    if @verdicts[3] == 1
      if @verdicts[4] == 1
        @sig_inc_map << @static_contents["increase_3_4"]
      else
        @sig_inc_map << @static_contents["increase_3"]
      end
    elsif @verdicts[4] == 1
      @sig_inc_map << @static_contents["increase_4"]
    end

    if @verdicts[5] == 1
      if @verdicts[6] == 1
        if @verdicts[7] == 1
          @sig_inc_map << @static_contents["increase_5_6_7"]
        else
          @sig_inc_map << @static_contents["increase_5_6"]
        end
      else
        if @verdicts[7] == 1
          @sig_inc_map << @static_contents["increase_5_7"]
        else
          @sig_inc_map << @static_contents["increase_5"]
        end
      end
    elsif @verdicts[6] == 1
      if @verdicts[7] == 1
        @sig_inc_map << @static_contents["increase_6_7"]
      else
        @sig_inc_map << @static_contents["increase_6"]
      end
    elsif @verdicts[7] == 1
      @sig_inc_map << @static_contents["increase_7"]
    end

    if @verdicts[8] == 1
      if @verdicts[9] == 1
        if @verdicts[10] == 1
          @sig_inc_map << @static_contents["increase_8_9_10"]
        else
          @sig_inc_map << @static_contents["increase_8_9"]
        end
      else
        if @verdicts[10] == 1
          @sig_inc_map << @static_contents["increase_8_10"]
        else
          @sig_inc_map << @static_contents["increase_8"]
        end
      end
    elsif @verdicts[9] == 1
      if @verdicts[10] == 1
        @sig_inc_map << @static_contents["increase_9_10"]
      else
        @sig_inc_map << @static_contents["increase_9"]
      end
    elsif @verdicts[10] == 1
      @sig_inc_map << @static_contents["increase_10"]
    end

    @sig_dec_map = []

    if @verdicts[1] == -1
      if @verdicts[2] == -1
        @sig_dec_map << @static_contents["decrease_1_2"]
      else
        @sig_dec_map << @static_contents["decrease_1"]
      end
    elsif @verdicts[2] == -1
      @sig_dec_map << @static_contents["decrease_2"]
    end

    if @verdicts[3] == -1
      if @verdicts[4] == -1
        @sig_dec_map << @static_contents["decrease_3_4"]
      else
        @sig_dec_map << @static_contents["decrease_3"]
      end
    elsif @verdicts[4] == -1
      @sig_dec_map << @static_contents["decrease_4"]
    end

    if @verdicts[5] == -1
      if @verdicts[6] == -1
        if @verdicts[7] == -1
          @sig_dec_map << @static_contents["decrease_5_6_7"]
        else
          @sig_dec_map << @static_contents["decrease_5_6"]
        end
      else
        if @verdicts[7] == -1
          @sig_dec_map << @static_contents["decrease_5_7"]
        else
          @sig_dec_map << @static_contents["decrease_5"]
        end
      end
    elsif @verdicts[6] == -1
      if @verdicts[7] == -1
        @sig_dec_map << @static_contents["decrease_6_7"]
      else
        @sig_dec_map << @static_contents["decrease_6"]
      end
    elsif @verdicts[7] == -1
      @sig_dec_map << @static_contents["decrease_7"]
    end

    if @verdicts[8] == -1
      if @verdicts[9] == -1
        if @verdicts[10] == -1
          @sig_dec_map << @static_contents["decrease_8_9_10"]
        else
          @sig_dec_map << @static_contents["decrease_8_9"]
        end
      else
        if @verdicts[10] == -1
          @sig_dec_map << @static_contents["decrease_8_10"]
        else
          @sig_dec_map << @static_contents["decrease_8"]
        end
      end
    elsif @verdicts[9] == -1
      if @verdicts[10] == -1
        @sig_dec_map << @static_contents["decrease_9_10"]
      else
        @sig_dec_map << @static_contents["decrease_9"]
      end
    elsif @verdicts[10] == -1
      @sig_dec_map << @static_contents["decrease_10"]
    end

  end

  def generate_fj_data
   @names = Set.new
    @fjs = @school_semester.food_journals
    @fjs.each do |fj|
      @names.add(fj.student_name)
    end
    @diffs = {"fruit" => [], "vegetable" => [], "sugary_drink" => [], "water" => []}
    @pre = {}
    @post = {}
    @mid = {}
    @base = {"fruit" => [], "vegetable" => [], "sugary_drink" => [], "water" => []}
    @midgraph = {"fruit" => [], "vegetable" => [], "sugary_drink" => [], "water" => []}
    @endgraph = {"fruit" => [], "vegetable" => [], "sugary_drink" => [], "water" => []}
    @fj_increase = []
    @fj_decrease = []
    @names.each do |name|
      student_fjs = @fjs.find_all_by_student_name(name)
      if student_fjs.size == 3
        student_fjs.each do |fj|
          if fj.week_num == 1
            @pre = {"fruit" => fj.fruit, "vegetable" => fj.vegetable, "sugary_drink" => fj.sugary_drink, "water" => fj.water}
          elsif fj.week_num == 8
            @post = {"fruit" => fj.fruit, "vegetable" => fj.vegetable, "sugary_drink" => fj.sugary_drink, "water" => fj.water}
          else
            @x = fj.week_num
            @mid = {"fruit" => fj.fruit, "vegetable" => fj.vegetable, "sugary_drink" => fj.sugary_drink, "water" => fj.water}
          end
        end
        @diffs.each do |category, array|
          @diffs[category] = @diffs[category] << @post[category] - @pre[category]
          @base[category] = @base[category] << @pre[category]
          @midgraph[category] = @midgraph[category] << @mid[category]
          @endgraph[category] = @endgraph[category] << @post[category]
        end
      end
    end
    @basemean ={}
    @midmean ={}
    @endmean ={}
    @base.each do |category, array|
      sum = 0
      array.each do |num|
        sum += num
      end
      @basemean[category] = sum/(array.size*1.0)
    end
    @midgraph.each do |category, array|
      sum = 0
      array.each do |num|
        sum += num
      end
      @midmean[category] = sum/(array.size*1.0)
    end
    @endgraph.each do |category, array|
      sum = 0
      array.each do |num|
        sum += num
      end
      @endmean[category] = sum/(array.size*1.0)
    end
    @mean = {}
    @percentage = {}
    @sd = {}
    @fj_t = {}
    @fj_verdict = {}
    @diffs.each do |category, array|
      sum = 0
      base_sum = 0
      array.each do |num|
        sum += num
      end
      @base[category].each do |num|
        base_sum += num
      end
      size = array.size
      @mean[category] = sum*1.0/size
      @percentage[category] = (((@mean[category]/(base_sum*1.0/@base[category].size)).round 2)*100).abs
      diff_square = 0
      array.each do |num|
        diff_square += (num - @mean[category])*(num - @mean[category])
      end
      @sd[category] = Math.sqrt(diff_square/(size - 1.0))
      @fj_t[category] = @mean[category]/(@sd[category]/Math.sqrt(size*1.0))
      @fj_verdict[category] = @fj_t[category] > @T[size - 1]
      if @fj_verdict[category]
        if @mean[category] > 0
          @fj_increase << category
        else
          @fj_decrease << category
        end
      end
    end
    
    @fj_inc = []
    @fj_dec = []
    if @fj_increase.include?("vegetable")
      @fj_inc << "Vegetable (#{@percentage["vegetable"]}%)"
    end
    if @fj_increase.include?("fruit")
      @fj_inc << "Fruit (#{@percentage["fruit"]}%)"
    end
    if @fj_increase.include?("sugary_drink")
      @fj_inc << "Sugar Sweetened Beverages (#{@percentage["sugary_drink"]}%)"
    end
    if @fj_increase.include?("water")
      @fj_inc << "Water (#{@percentage["water"]}%)"
    end
    p @fj_increase
    p @fj_inc
    if @fj_decrease.include?("vegetable")
      @fj_dec << "Vegetable (#{@percentage["vegetable"]}%)"
    end
    if @fj_decrease.include?("fruit")
      @fj_dec << "Fruit (#{@percentage["fruit"]}%)"
    end
    if @fj_decrease.include?("sugary_drink")
      @fj_dec << "Sugar Sweetened Beverages (#{@percentage["sugary_drink"]}%)"
    end
    if @fj_decrease.include?("water")
      @fj_dec << "Water (#{@percentage["water"]}%)"
    end

    @fj_serving_intro = "Students who attended weeks 1, #{@x}, and 8 were included in this analysis. #{@names.size} students are therefore included. The average number of servings for vegetables, fruits, sugar sweetened beverages, and water were tracked over the lesson series to investigate changes in consumption patterns."
    unfav = ""
    if @fj_decrease.include?("vegetable")
      unfav = "vegetables"
    end
    if @fj_decrease.include?("fruit")
      if unfav.size > 0
        unfav += "/fruit"
      else
        unfav = "fruit"
      end
    end
    if @fj_decrease.include?("water")
      if unfav.size > 0
        unfav += "/water"
      else
        unfav = "water"
      end
    end
    if @fj_increase.include?("sugary_drink")
      if unfav.size > 0
        unfav += "; increase in consumption of sugar sweetened beverages"
      else
        unfav = "increase in consumption of sugar sweetened beverages"
      end
    end
    if unfav.size > 0
      @fj_unfavorable = "The food journals show #{unfav}. The estimates of number of servings may have become more accurate as the lesson series went along, thus skewing the results depending on whether students tended to underestimate or overestimate servings. In addition, one should observe the line graph to see the overall trend, as measuring the difference between week 1 and week 8 only can be misleading."
    else
      @fj_unfavorable = ""
    end

    nonsig = ""
    if (not @fj_increase.include?("vegetable")) and @mean["vegetable"] > 0
      nonsig = "vegetable"
    end
    if (not @fj_increase.include?("fruit")) and @mean["fruit"] > 0
      if nonsig.size > 0
        nonsig += "/fruit"
      else
        nonsig = "fruit"
      end
    end
    if (not @fj_increase.include?("water")) and @mean["water"] > 0
      if nonsig.size > 0
        nonsig += "/water"
      else
        nonsig = "water"
      end
    end
    if nonsig.size > 0
      nonsig += " increase"
    end
    if (not @fj_decrease.include?("sugary_drink")) and @mean["sugary_drink"] < 0
      if nonsig.size > 0
        nonsig += "; sugar sweetened beverage consumption decrease"
      else
        nonsig = "sugar sweetened beverage consumption decrease"
      end
    end
    if nonsig.size > 0
      @fj_nonsig = "Students did not appear to be significantly affected by Fruitful Minds lessons, but the data show change in a positive direction for #{nonsig}. This indicates that students made minor adjustments to their intake."
    else 
      @fj_nonsig = ""
    end

    fav = ""
    if @fj_increase.include?("vegetable")
      fav = "Vegetables"
    end
    if @fj_increase.include?("fruit")
      if fav.size > 0
        fav += ", Fruit"
      else
        fav = "Fruit"
      end
    end
    if @fj_increase.include?("water")
      if fav.size > 0
        fav += ", Water"
      else
        fav = "Water"
      end
    end
    if @fj_decrease.include?("sugary_drink")
      if fav.size > 0
        fav += ", Sugar Sweetened Beverages"
      else
        fav = "Sugar Sweetened Beverages"
      end
    end
    if fav.size > 0
      @fj_favorable = "Fruitful Minds lessons were able to positively impact the consumption of #{fav} over the course of the lesson series. Although long-term behavior change cannot be gauged, this shows that students put their nutrition knowledge to work in making healthier choices."
    else
      @fj_favorable = ""
    end
  end

  def generate_strengths
    @all_strengths = { 
                   "S1Q1 Strengths" => "Students could identify factors that may lead to type 2 diabetes",
                   "S1Q2 Strengths" => "Students understood that poor diet and lack of exercise increase risk for many diseases regardless of one\'s body size.",
                   "S2Q1 Strengths" => "Students learned the five different food groups included in USDA\'s MyPlate.",
                   "S2Q2 Strengths" => "Students understood that all five food groups are important to help us achieve a balanced diet.",
                   "S2Q3 Strengths" => "Students understood that frozen fruits and vegetables are not nutritionally inferior to fresh fruits and vegetables.",
                   "S2Q4 Strengths" => "Students could recall the numbers of servings one needs for each food group.",
                   "S3Q1 Strengths" => "Students could recall the different macro- and micronutrients.",
                   "S3Q2 Strengths" => "Students could distinguish between nutrients.",
                   "S3Q3 Strengths" => "Students were able to identify foods rich in fiber.",
                   "S3Q4 Strengths" => "Students understood the difference between healthy and unhealthy fats.",
                   "S3Q5 Strengths" => "Students understood that vitamins have specific functions in the body.",
                   "S3Q6 Strengths" => "Students were aware of which nutrients tend to be beneficial, and which nutrients tend to be harmful when consumed in excess.",
                   "S4Q1 Strengths" => "Students understood that calories are a measure of energy in food.",
                   "S4Q2 Strengths" => "Students were able to use the nutrition label to identify food products with too much salt.",
                   "S4Q3 Strengths" => "Students could calculate the numbers of servings in a food package.",
                   "S5Q1 Strengths" => "Students recognized the goals of food advertisements as well as the techniques that food companies use to promote their products.",
                   "S5Q2 Strengths" => "Students were able to distinguish between the advertising and factual components on a food package.",
                   "S6Q1 Strengths" => "Students demonstrated knowledge in the benefits of physical activity.",
                   "S6Q2 Strengths" => "Students were aware of the recommended amount of exercise.",
                   "S6Q3 Strengths" => "Students could identify different types of physical activity.",
                   "S6Q4 Strengths" => "Students understood energy balance and that excess energy can become fat."
                 }
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3, 5 => 2, 6 => 4}
    @ps = @school_semester.postsurveys[0]
    @strengths = {}
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @efficacy_change = @ps["section_#{section}_#{i + 1}"]
        if @efficacy_change*1.0/@ps.number_students > 0.80
          @strengths["S#{section}Q#{i + 1} Strengths"] = @all_strengths["S#{section}Q#{i + 1} Strengths"]
        end
      end
    end
    @strengths
  end

  def generate_weaknesses
    @all_weaknesses = {
                    "S1Q1 Weakness" => "Students had trouble identifying factors that may lead to type 2 diabetes.",
                    "S1Q2 Weaknesses" => "Students had trouble understanding that poor diet and lack of exercise increase risk for many diseases regardless of one\'s body size.",
                    "S2Q1 Weaknesses" => "Students could not recall all five food groups included in USDA\'s MyPlate.",
                    "S2Q2 Weaknesses" => "Students did not understand that all five food groups are important to help us achieve a balanced diet, even though some food groups should be consumed more than others.",
                    "S2Q3 Weaknesses" => "Students did not understand that frozen fruits and vegetables are as healthy as fresh fruits and vegetables.",
                    "S2Q4 Weaknesses" => "Students did not remember the numbers of servings recommended for each food group.",
                    "S3Q1 Weaknesses" => "Students had trouble recalling nutrients and distinguishing between food groups and nutrients.",
                    "S3Q2 Weaknesses" => "Students did not completely understand the difference between each nutrient.",
                    "S3Q3 Weaknesses" => "Students had trouble identifying which foods are rich in fiber.",
                    "S3Q4 Weaknesses" => "Students did not completely understand that some fats are healthier than others.",
                    "S3Q5 Weaknesses" => "Students had trouble matching functions to the corresponding vitamins.",
                    "S3Q6 Weaknesses" => "Students had trouble identifying which nutrients tend to be more beneficial and which tend to be harmful when consumed in excess.",
                    "S4Q1 Weaknesses" => "Students had trouble interpreting the meaning of a calorie.",
                    "S4Q2 Weaknesses" => "Students did not understand how to use the nutritional label to identify food products with too much salt.",
                    "S4Q3 Weaknesses" => "Students had trouble using math to calculate the numbers of servings in a food package.",
                    "S5Q1 Weaknesses" => "Students had trouble identifying the goals of food advertisements.",
                    "S5Q2 Weaknesses" => "Students had trouble distinguishing between the advertising and factual components on a food package.",
                    "S6Q1 Weaknesses" => "Students didn\'t completely understand the benefits of exercise.",
                    "S6Q2 Weaknesses" => "Students were not able to recall the recommended amount of exercise for children.",
                    "S6Q3 Weaknesses" => "Students had trouble identifying different types of physical activity.",
                    "S6Q4 Weaknesses" => "Students did not understand the consequences of consuming excess energy."
                  }

  section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3, 5 => 2, 6 => 4}
    @ps = @school_semester.postsurveys[0]
    @weaknesses = {}
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @efficacy_change = @ps["section_#{section}_#{i + 1}"]
        if @efficacy_change*1.0/@ps.number_students < 0.50
          @weaknesses["S#{section}Q#{i + 1} Weaknesses"] = @all_weaknesses["S#{section}Q#{i + 1} Weaknesses"]
        end
      end
    end
    return @weaknesses
  end
  
  def index
    redirect_to "/reports/new"
  end
  
  def generate_graph
    @topicPre = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}
    @topicPost = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3}
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @topicPre[section] += @ps_part1["section_#{section}_#{i + 1}"]
      end
    end
    section_and_num_questions = {5 => 2, 6 => 4}
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @topicPre[section] += @ps_part2["section_#{section}_#{i + 1}"]
      end
    end
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3, 5 => 2, 6 => 4}
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @topicPost[section] += @ps["section_#{section}_#{i + 1}"]
      end
    end
    6.times do |i|
      if i < 4
        @topicPre[i + 1] =@topicPre[i + 1]*1.0/@ps_part1.number_students*1.0/section_and_num_questions[i+1]
      else
        @topicPre[i + 1] =@topicPre[i + 1]*1.0/@ps_part2.number_students*1.0/section_and_num_questions[i+1]
      end
    end
    6.times do |i|
      @topicPost[i + 1] =@topicPost[i + 1]*1.0/@ps.number_students*1.0/section_and_num_questions[i+1]
    end
  end

  # Compute efficacy for each semester of each school that has a record in SchoolSemester
  def all_efficacies
    @ss_efficacies = []
    SchoolSemester.all.each do |ss|
      pre1_efficacy = calculate_pre_efficacy_part1_for_school_semester(ss)
      pre2_efficacy = calculate_pre_efficacy_part2_for_school_semester(ss)
      pre_efficacy = (pre1_efficacy + pre2_efficacy)/21.0
      if pre_efficacy != 0
        post_efficacy = calculate_post_efficacy_for_school_semester(ss)
        @ss_efficacies << {
          :school => ss.school,
          :semester_name => ss.name,
          :semester_year => ss.year,
          :efficacy => ( (post_efficacy - pre_efficacy) * 100.0 / pre_efficacy ).round(2)
        }
      end
    end
  end

  def calculate_pre_efficacy_part1_for_school_semester school_semester
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3}
    efficacy = 0
    ps_part1 = school_semester.presurvey_part1s[0]
    if not ps_part1.nil?
      section_and_num_questions.each do |section,questions|
        questions.times do |i|
          efficacy += ps_part1["section_#{section}_#{i + 1}"]
        end
      end
      if ps_part1.number_students != 0
        efficacy = efficacy*1.0/ps_part1.number_students
      end
    end
    return efficacy
  end

  def calculate_pre_efficacy_part2_for_school_semester school_semester
    section_and_num_questions = {5 => 2, 6 => 4}
    ps_part2 = school_semester.presurvey_part2s[0]
    efficacy = 0
    if not ps_part2.nil?
      section_and_num_questions.each do |section,questions|
        questions.times do |i|
          if !(ps_part2["section_#{section}_#{i + 1}"]).nil?
            efficacy += ps_part2["section_#{section}_#{i + 1}"]
          end
        end
      end
      if ps_part2.number_students != 0
        efficacy = efficacy*1.0/ps_part2.number_students
      end
    end
    return efficacy
  end

  def calculate_post_efficacy_for_school_semester school_semester
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3, 5 => 2, 6 => 4}
    ps = school_semester.postsurveys[0]
    efficacy = 0
    if not ps.nil?
      section_and_num_questions.each do |section,questions|
        questions.times do |i|
          efficacy += ps["section_#{section}_#{i + 1}"]
        end
      end
      if ps.number_students != 0
        efficacy = (efficacy*1.0/ps.number_students)/21.0
      end
    end
    return efficacy
  end

  def calculate_efficacy
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3}
    @efficacy_pre = 0
    @ps_part1 = @school_semester.presurvey_part1s[0]
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @efficacy_pre += @ps_part1["section_#{section}_#{i + 1}"]
      end
    end
    if @ps_part1.number_students != 0
      @efficacy_pre = @efficacy_pre*1.0/@ps_part1.number_students
    end
    section_and_num_questions = {5 => 2, 6 => 4}
    @ps_part2 = @school_semester.presurvey_part2s[0]
    @efficacy_pre2 = 0
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        if !(@ps_part2["section_#{section}_#{i + 1}"]).nil?
          @efficacy_pre2 += @ps_part2["section_#{section}_#{i + 1}"]
        end
      end
    end
    if @ps_part2.number_students != 0
      @efficacy_pre2 = @efficacy_pre2*1.0/@ps_part2.number_students
    end
    @efficacy_pre = (@efficacy_pre + @efficacy_pre2)/21.0
    section_and_num_questions = {1 => 2, 2 => 4, 3 => 6, 4 => 3, 5 => 2, 6 => 4}
    @ps = @school_semester.postsurveys[0]
    @efficacy_post = 0
    section_and_num_questions.each do |section,questions|
      questions.times do |i|
        @efficacy_post += @ps["section_#{section}_#{i + 1}"]
      end
    end
    if @ps.number_students != 0
      @efficacy_post = (@efficacy_post*1.0/@ps.number_students)/21.0
    end
    if @efficacy_pre != 0
      return ((@efficacy_post-@efficacy_pre)*100.0/@efficacy_pre).round 2
    end
  end
end
