module ReportsGraphHelper

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
    @improvement = combined_data[1] - combined_data[0]
    if not @improvement[0].nil?
      @improvement = @improvement[0].round(2)
    else
      @improvement[0] = 0
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
end
