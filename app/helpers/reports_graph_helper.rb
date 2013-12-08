module ReportsGraphHelper


  ############################# EFFICACY ##############################

  def generate_efficacy_graph(data_list)
    #data_list is a list of hashes [{presurvey},{postsurvey}]
    #hashes are {q_id => value}
    if data_list.nil?
      return
    end
    labels = efficacy_graph_setup

    data, combined_data, graph_height = calculate_efficacy_graph_values(data_list)

    setup_efficacy_improvement(combined_data)
    size = '500x' + graph_height.to_s
    generate_efficacy_chart(size, data, labels)

  end

  def efficacy_graph_setup
    #axes = []
    labels = ""
    @curriculum.sections.each do |section_id|
      section = Section.find_by_id(section_id)
      next if section.stype != 'Efficacy'
      section.questions.each do |q_id|
        question = Question.find_by_id(q_id)
        labels += question.name + "|"
        #axes.push(question.name)
      end
    end
    labels.chomp "|"
    return labels
  end

  def setup_efficacy_improvement(combined_data)
    @efficacy_improvement = combined_data[1] - combined_data[0]
    if @efficacy_improvement.nil?
      @efficacy_improvement = 0
    end
  end

  def calculate_efficacy_graph_values(data_list)
    data = []
    @max = 0
    combined_data = []
    graph_height = 60
    data_list.each do |survey_hash| #formats data to be [[presurvey_values],[postsurvey_values]]
      combined = 0
      survey_list = []
      graph_height = 60
      survey_hash.values.each do |value|
        survey_list.push(value)
        combined += value
        graph_height += 25
      end
      combined_data.push(combined)
      data.push(survey_list)
      if survey_list.size > 0 and survey_list.compact.max > @max
        @max = survey_list.compact.max
      end
    end
    return data, combined_data, graph_height
  end


  def generate_efficacy_chart(size, data, labels)
    @efficacy_chart = Gchart.bar(:size => size,
                                 :title => "Efficacy Survey Results - Agreement(%)",
                                 :legend => ['Pre', 'Post'],
                                 :bar_colors => '990000,3399CC',
                                 :data => data,
                                 :bar_width_and_spacing => '10,0,5',
                                 :axis_with_labels => 'y,x',
                                 :axis_labels => [labels],
                                 :stacked => false,
                                 :axis_range => [nil, [0,@max,10]],
                                 :orientation => 'horizontal'
                                 )
  end

end
