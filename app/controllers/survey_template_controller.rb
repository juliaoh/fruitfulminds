class SurveyTemplateController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def index
    @survey_templates = Curriculum.all
  end
  def new
  end
  def create
    create_curriculum(params)
    num_sections = params[:num_sections].to_i
    (1 .. num_sections).each do |sec_number|
      begin
        sec_num_qs = params["snumquestions#{sec_number}".to_sym].to_i
        create_section(params, sec_number)
        question_prefix = "s#{sec_number}q"
        (1 .. sec_num_qs).each do |question_number|
          q_name_param = question_prefix+question_number.to_s
          create_question(params, q_name_param)
        end
      rescue
        next
      end
    end
    redirect_to "/survey_template"
  end

  def create_curriculum(params)
    survey_name = params[:surveyname]
    @survey_template = Curriculum.new(:name => survey_name)
    @survey_template.save
  end

  def create_question(params, q_name_param)
    question_name = params[(q_name_param+"name").to_sym]
    str_message = params[(q_name_param+"strength").to_sym]
    wkns_message = params[(q_name_param+"weakness").to_sym]
    @tmp_section.create_and_save_question({:name => question_name, :qtype => @tmp_section.stype, :msg1 => str_message, :msg2 => wkns_message})
  end


  def create_section(params, sec_number)
    section_name = params["sname#{sec_number}".to_sym].to_s
    section_type = params["stype#{sec_number}".to_sym].to_s
    if section_type == "Multiple Choice"
      section_obj = params["sobjective#{sec_number}".to_sym].to_s
    else
      section_obj = nil
    end
    @tmp_section = @survey_template.create_and_save_section(:name => section_name, :stype => section_type, :objective => section_obj)
  end

end
