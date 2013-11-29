pdf.text " "
pdf.image "#{Rails.root}/app/assets/images/fm_icon.jpg"
pdf.text " "
pdf.text "Fruitful Minds", :align => :left, :size =>18, :style => :bold
pdf.text " "
pdf.text @school_name, :align => :left, :size => 18, :style => :bold
pdf.text " "
pdf.text @main_semester_title, :align => :left, :size => 18, :style => :bold
pdf.text " "
pdf.text " "
pdf.text @static_contents[:intro_title], :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:introduction]
pdf.text " "
pdf.text @school_intro_title, :size => 14, :style => :bold
pdf.text " "
pdf.text @school_intro
pdf.text " "
pdf.text @school_intro_second
pdf.text " "
pdf.text @school_intro_third
pdf.start_new_page
pdf.text @static_contents[:objectives_title], :size => 14, :style => :bold
pdf.text " "
pdf.table(@objectivesTable, :header => true)
pdf.text " "
pdf.text " "
pdf.text @static_contents[:eval_title], :size => 14, :style => :bold
pdf.text " "
pdf.text @eval_intro_first
pdf.text " "
pdf.text @eval_intro_second
pdf.text " "
pdf.text @eval_intro_third
pdf.text " "
pdf.text " "
pdf.text " "
pdf.start_new_page
pdf.image open(URI.escape(@nutrition_chart)) 
pdf.text " "
pdf.image open(URI.escape(@combined_chart))

pdf.start_new_page
pdf.text @strength_weakness_title, :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:strength_weakness_intro]
pdf.text " "
pdf.text @static_contents[:strength_intro], :size => 14, :style => :bold
pdf.text " "

@objective_str.values.each do |strength|
  pdf.text "•#{strength}"
end

pdf.text " "
pdf.text @static_contents[:weakness_intro], :size => 14, :style => :bold

@objective_weak.values.each do |weakness|
  pdf.text "•#{weakness}"
end

pdf.text " "
pdf.text @static_contents[:comp_intro], :size => 14, :style => :bold

@objective_comp.values.each do |comp|
  pdf.text "•#{comp}"
end



pdf.text " "
pdf.text @static_contents[:summary]
pdf.text " "

pdf.text @static_contents[:behavior_title], :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:behavior_intro]
pdf.text " "
pdf.start_new_page
pdf.image open(URI.escape(@efficacy_chart)), :align => :center
pdf.text " "
pdf.text @improvement_intro
pdf.text " "

pdf.text @static_contents[:increase_header], :style => :bold
pdf.text " "
@efficacy_str.values.each do |q_msg|
  pdf.text "•#{q_msg}"
end
pdf.text " "
pdf.text @static_contents[:decrease_header], :style => :bold
pdf.text " "
@efficacy_weak.values.each do |q_msg|
  pdf.text "•#{q_msg}"
end
pdf.text " "
pdf.text @static_contents[:comp_header], :style => :bold
pdf.text " "
@efficacy_comp.values.each do |q_msg|
  pdf.text "•#{q_msg}"
end
pdf.start_new_page
pdf.text @static_contents[:summary_header], :style => :bold
pdf.text " "
@summary_messages.each do |msg|
  pdf.text "#{msg}"
end
pdf.text " "
pdf.text @ambassadorNoteTitle, :size => 14, :style => :bold
pdf.text " "
pdf.text @report_note

