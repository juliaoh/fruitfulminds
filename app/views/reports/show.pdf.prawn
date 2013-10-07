pdf.text " "
pdf.text @main_title, :align => :center, :size => 18, :style => :bold
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
pdf.text " "
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
pdf.image open(URI.escape(@nutrition_chart)) 
pdf.text " "
pdf.image open(URI.escape(@combined_chart))
pdf.text " "
pdf.text @strength_weakness_title, :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:strength_weakness_intro]
pdf.text " "
pdf.text @static_contents[:strength_intro], :size => 14, :style => :bold
pdf.text " "


@strengths.each do |key, strength|
  pdf.text "#{strength}"
end

pdf.text " "
pdf.text @static_contents[:weakness_intro], :size => 14, :style => :bold

@weaknesses.each do |key, weakness|
  pdf.text "#{weakness}"
end


pdf.text " "
pdf.text @static_contents[:summary]
pdf.text " "

pdf.text @static_contents[:behavior_title], :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:behavior_intro]
pdf.text " "
pdf.image open(URI.escape(@efficacy_chart)), :align => :center
pdf.text " "
pdf.text @improvement_intro
pdf.text " "
@sig_increase.each do |agree|
  pdf.text "#{agree}"
end
pdf.text " "
pdf.text @static_contents[:slight_increase_header], :style => :bold
pdf.text " "
@slight_increase.each do |agree|
  pdf.text "#{agree}"
end
pdf.text " "
pdf.text @static_contents[:decrease_header], :style => :bold
pdf.text " "
@sig_decrease.each do |disagree|
  pdf.text "#{disagree}"
end
pdf.text " "
pdf.text @static_contents[:slight_decrease_header], :style => :bold
pdf.text " "
@slight_decrease.each do |disagree|
  pdf.text "#{disagree}"
end
pdf.text " "
pdf.text @static_contents[:summary_header], :style => :bold
pdf.text " "
@sig_inc_map.each do |agree|
  pdf.text "#{agree}"
end
pdf.text " "
@sig_dec_map.each do |disagree|
  pdf.text "#{disagree}"
end
pdf.text " "
pdf.text @static_contents[:food_journal_header], :size => 14, :style => :bold
pdf.text " "
pdf.text @static_contents[:food_journal_intro]
pdf.text " "
pdf.text @static_contents[:fj_increase_header], :style => :bold
pdf.text " "
@fj_inc.each do |result|
  pdf.text "#{result}"
end
pdf.text " "
pdf.text @static_contents[:fj_decrease_header], :style => :bold
pdf.text " "
@fj_dec.each do |result|
  pdf.text "#{result}"
end
pdf.text " "
pdf.text @fj_unfavorable
pdf.text " "
pdf.text @fj_nonsig
pdf.text " "
pdf.text @fj_favorable
pdf.text " "
pdf.text @ambassadorNoteTitle, :size => 14, :style => :bold
pdf.text " "
pdf.text @reportNote

