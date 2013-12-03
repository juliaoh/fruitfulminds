class SurveyTemplateController < ApplicationController
  before_filter :admin_only
  skip_before_filter :verify_authenticity_token, :only => [:create, :update]
  def index
    @unpublished_templates = Curriculum.where(:published => false)
    @published_templates = Curriculum.where(:published => true)
  end
  def new
  end
  def edit
    template_fields = Curriculum.find(params[:id])
    @published = template_fields.published
    @survey_name = template_fields.name
    @sections = template_fields.sections
  end
  def update
    Curriculum.find(params[:id]).destroy
    create
    if flash[:notice] == "New Survey successfully added."
        flash[:notice] = "Survey successfully updated."
    end
  end

  def create
    survey_name = params[:surveyname]
    if survey_name == nil or survey_name == ''
      flash[:notice] = "There are blank fields"
      redirect_to "/survey_template/new" and return
    end
    puts "Has key: " + params.has_key?(:publish).to_s
    if params.has_key?(:publish)
      published = true
    else
      published = false
    end
    create_curriculum(survey_name, published)
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
    flash[:notice] = "New Survey successfully added."
    redirect_to "/survey_template"
  end

  def create_curriculum(survey_name, published)
    @survey_template = Curriculum.new(:name => survey_name, :published => published)
    @survey_template.save
  end
  def update_curriculum(survey_name)
    @survey_template = Curriculum.find(params[:id]).update_attributes!(:name => survey_name)
    @survey_template.save
  end

  def create_question(params, q_name_param)
    question_name = params[(q_name_param+"name").to_sym]
    message = params[(q_name_param+"msg").to_sym]
    @tmp_section.create_and_save_question({:name => question_name, :qtype => @tmp_section.stype, :msg => message})
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
  
  def destroy
    @template = Curriculum.find(params[:id])
    @template.destroy
    flash[:notice] = "Template successfully deleted."
    redirect_to survey_template_index_path
  end
end
