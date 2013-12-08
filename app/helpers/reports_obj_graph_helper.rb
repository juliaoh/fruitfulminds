module ReportsObjGraphHelper
  ############################### OBJECTIVE ###############################

  def generate_objective_graph(data_list)
    #data_list is a list of hashes [{presurvey},{postsurvey}]
    #hashes are {q_id => value}
    #graph should be
    #y-axis: % value
    #x-axis SECTIONS (not q_id/questions)

    if data_list.nil?
      return
    end

    # objective_graph_setup is a helper function down below
    labels, graph_width = objective_graph_setup

    data = []
    combined_data = []
    data, combined_data = format_objective_data(data_list)
    if data.nil? or combined_data.nil?
      return
    end

    #setup_improvement is a helper function down below
    setup_improvement(combined_data)

    prescore = combined_data[0]
    postscore = combined_data[1]
    size = graph_width.to_s + 'x300'

    generate_nutrition_chart(size, data, labels)
    generate_combined_chart(prescore, postscore, combined_data)
  end

  def objective_graph_setup
    #axes = []
    labels = ""
    graph_width = 100
    @objectives.keys.each do |section_name|
      if section_name.length > 12
        section_name = section_name[0..11] + "..."
      end
      #axes.push(section_name)
      labels += section_name+"|"
      graph_width += 83
    end
    labels.chomp('|')
    return labels, graph_width
  end

  def setup_improvement(combined_data)
    @improvement = combined_data[1][0] - combined_data[0][0]
    if not @improvement.nil?
      @improvement = @improvement.round(2)
    else
      @improvement = 0
    end
  end

  def generate_nutrition_chart(size, data, labels)
    @nutrition_chart = Gchart.bar(:size => size,
                                :title => "Survey Score in Nutrition Topics(%)",
                                :legend => ['Pre', 'Post'],
                                :bar_colors => '3399CC,99CCFF',
                                :data => data,
                                :bar_width_and_spacing => '30,0,23',
                                :axis_with_labels => 'x,y',
                                :axis_labels => [labels],
                                :stacked => false,
                                :axis_range => [nil, [0,@max,10]]
                                )
  end

  def generate_combined_chart(prescore, postscore, combined_data)
    @combined_chart = Gchart.bar(:size => '1000x300',
                                 :title => "Overall Combined Scores(%)",
                                 :legend => ['Pre-curriculum Results (' + prescore[0].round(2).to_s + '%)', 'Post-curriculum Results (' + postscore[0].round(2).to_s + '%)'],
                                 :bar_colors => 'FF3333,990000',
                                 :data => combined_data,
                                 :bar_width_and_spacing => '50,25,25',
                                 :axis_with_labels => 'y',
                                 :stacked => false,
                                 :axis_range => [[0,@combined_max,10]]
                                 )

  end



    def format_objective_data(data_list)
    #data_list is [{presurvey},{postsurvey}]
    #pre/postsurvey are {q_id => value}
    #this function will sum up the q_values for each section
    #also returns combined_data which sums up q_values for all pre vs post
    # returns [data, combined_data]
    # format of data and combined data is [[presurvey],[postsurvey]]
    # where pre/post are just a list of values e.g. data = [[2,4,5],[5,8,9]]

    data = []
    combined_data = []

    @max = 0
    @combined_max = 0
    pre_data = []
    post_data = []
    pre_combined = [0]
    post_combined = [0]

    # what the heck does the bottom code do?
    #questions = ""
    #data_list[0].keys.each do |q_id|
    #  questions += " " + Question.find_by_id(q_id).name + " qid: " + q_id.to_s
    #end
    #values = ""
    #data_list[0].values.each do |v|
    #  values += " " + v.to_s
    #end

    total_question_count = format_objective_data_helper(data_list, pre_combined, post_combined, pre_data, post_data)
    pre_combined[0] /= total_question_count
    post_combined[0] /= total_question_count
    @max = [pre_data.compact.max, post_data.compact.max].max
    @combined_max = [pre_combined[0], post_combined[0]].max
    data = [pre_data, post_data]
    params[:bob] = pre_combined[0]
    params[:jenkins] = post_combined[0]
    combined_data = [pre_combined, post_combined]
    return data, combined_data
  end

  def format_objective_data_helper(data_list, pre_combined, post_combined, pre_data, post_data)
    total_question_count = 0
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != 'Multiple Choice'
      section_pre_total, section_post_total, section_question_count = process_data_per_section(section, data_list, pre_combined, post_combined)
      total_question_count += section_question_count
      pre_data.push(section_pre_total/section_question_count)
      post_data.push(section_post_total/section_question_count)
    end
    return total_question_count
  end

  def check_for_incomplete_data(q_id, data_list)
    if data_list[0][q_id].nil? or data_list[1][q_id].nil?
      question = Question.find_by_id(q_id)
      flash[:warning] = "Unexpected error with data (Check if data is incomplete)"
      redirect_to "/reports/new" and return
    end
  end

  def process_data_per_section(section, data_list, pre_combined, post_combined)
    section_pre_total = 0
    section_post_total = 0
    section_question_count = 0
    section.questions.each do |question|
      q_id = question.id
      check_for_incomplete_data(q_id, data_list)
      section_pre_total += data_list[0][q_id]
      section_post_total += data_list[1][q_id]
      pre_combined[0] += data_list[0][q_id]
      post_combined[0] += data_list[1][q_id]
      section_question_count += 1
    end
    return section_pre_total, section_post_total, section_question_count
  end

end
