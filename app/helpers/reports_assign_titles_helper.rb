module ReportsAssignTitlesHelper

  include ReportsObjGraphHelper
  include ReportsGraphHelper

  def assign_titles
    @main_title = "Fruitful Minds #{@school_name} #{@school_semester} Report"
    @school_intro_title = "Fruitful Minds at #{@school_name}"
    @school_intro = "Fruitful Minds held a nutrition lesson series at #{@school_name} during #{@school_semester}"
    generate_school_intro_second
    @school_intro_third = "    During each lesson, class facilitators delivered the curriculum material through lectures, games, and various interactive activities."
    @strength_weakness_title = "Strengths and Weaknesses of FM Lessons at #{@school_name}"
    assign_efficacy_titles

    @ambassadorNoteTitle = "Ambassador Notes: "

  end

  def generate_school_intro_second
    @school_intro_second = "    "
    sum_ambassadors = 0
    @colleges_and_ambassador_counts.keys.each do |college|
      num_ambassadors = @colleges_and_ambassador_counts[college]
      sum_ambassadors += num_ambassadors
      student_str = "students"
      if num_ambassadors == 1
        student_str = "student"
      end
      @school_intro_second += "#{num_ambassadors} #{student_str} from #{college} and "
    end
    #strip the last and
    @school_intro_second = @school_intro_second[0..(@school_intro_second.size-5)]
    @school_intro_second += "#{was_were(sum_ambassadors)} selected as Fruitful Minds ambassadors"
  end

  def assign_efficacy_titles
    efficacy_data = generate_data('Efficacy')
    objective_data = generate_data('Multiple Choice')
    if efficacy_data.nil? or objective_data.nil?
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    elsif test_enough_data(efficacy_data, 'Efficacy')
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    elsif test_enough_data(objective_data, 'Multiple Choice')
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    elsif nan_data_test(objective_data, efficacy_data)
      flash[:warning] = "Not enough data"
      redirect_to "/reports/new" and return
    end
    efficacy_stats_handler(efficacy_data)
    objective_stats_handler(objective_data)
  end

  def nan_data_test(objective_data, efficacy_data)
    if has_nan(objective_data[0].values) or has_nan(objective_data[1].values)
      return true
    elsif has_nan(efficacy_data[0].values) or has_nan(efficacy_data[1].values)
      return true
    end
    return false
  end

  def has_nan(lst)
    lst.each do |elem|
      if elem.class == Float
        if elem.nan?
          return true
        end
      end
    return false
    end
  end

  def test_enough_data(data, title)
    (data[0].keys.length != @questions[title].length) or (data[1].keys.length != @questions[title].length)
  end

  def efficacy_stats_handler(efficacy_data)
    efficacy_stats = generate_strengths(efficacy_data)
    generate_efficacy_graph(efficacy_data)
    if not efficacy_stats.nil?
      @efficacy_str = efficacy_stats[0] #hash {q_name => msg}
      if @efficacy_str.keys.length == 0
        @efficacy_str['N/A'] = 'Students show no significant increase in agreement'
      end
      @efficacy_weak = efficacy_stats[1]
      @efficacy_comp = efficacy_stats[2]
      if @efficacy_comp.keys.length == 0
        @efficacy_comp['N/A'] = 'Students did not show competency in any areas of Fruitful Minds teaching prior to the lessons.'
      end
    end
  end

  def objective_stats_handler(objective_data)
    generate_objective_graph(objective_data)
    objective_stats = generate_strengths(objective_data)
    if not objective_stats.nil?
      @objective_str = objective_stats[0] #hash {q_name => msg}
      if @objective_str.keys.length == 0
        @objective_str['N/A'] = 'Students show no strengths'
      end
      @objective_weak = objective_stats[1]
      if @objective_weak.keys.length == 0
        @objective_weak['N/A'] = 'Students show no weaknesses'
      end
      @objective_comp = objective_stats[2]
      if @objective_comp.keys.length == 0
        @objective_comp['N/A'] = 'Students did not show competency in any areas of Fruitful Minds teaching prior to the lessons.'
      end
      @eval_intro_first = "Prior to the curriculum, a pre-curriculum survey was distributed to assess the students\' knowledge in nutrition; a very similar survey was administered during the final class. The goal of the surveys was to determine the retention of key learning objectives from the Fruitful Minds program."
      @eval_intro_second = "On average, students have shown a #{@improvement}% improvement after going through seven weeks of classes."
      @eval_intro_third = "The survey results are shown below. The first graph shows the average scores in each of the six nutrition topics covered in the curriculum (see graph 1). Note that the number of questions in each category varies. The second graph shows students\' overall performance on the pre-curriculum surveys and post-curriculum survey (see graph 2). #{@presurvey_total} students took the pre-curriculum survey, and #{@postsurvey_total} students took the post-curriculum surveys."
    end
  end
end
