class SurveyTemplateController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def index
    @survey_template = Curriculum.all
  end
  def new
  end
  def create
    flash[:notice] = params.to_s
    num_sections = params[:num_sections].to_i
    sections = []
    all_questions = []
    (1 .. num_sections).each do |sec_number|
      begin
        sec_num_qs = params["snumquestions#{sec_number}".to_sym].to_i
        section_name = params["sname#{sec_number}".to_sym].to_s
        section_type = params["stype#{sec_number}".to_sym].to_s
        if section_type == "Efficacy"
          section_obj = params["sobjective#{sec_number}".to_sym].to_s
        else
          section_obj = nil
        end
        question_prefix = "s#{sec_number}q"
        questions = []
        (1 .. sec_num_qs).each do |question_number|
          q_name_param = question_prefix+question_number.to_s
          question_name = params[(q_name_param+"name").to_sym]
          str_message = params[(q_name_param+"strength").to_sym]
          wkns_message = params[(q_name_param+"weakness").to_sym]
          question = Question.create(:name => question_name, :type => section_type, :msg1 => str_message, :msg2 => wkns_message)
          questions << question
          all_questions << question
        end
        section = Section.create(:name => section_name, :type => section_type, :objective => section_obj, :questions => questions)
        sections << section
      rescue
        next
      end
    end
    survey_name = params[:surveyname]
    @survey_template = Curriculum.create(:name => survey_name, :sections => sections)
    redirect_to "/survey_template"
  end
end
