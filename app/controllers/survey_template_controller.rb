class SurveyTemplateController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def index
  end
  def new
  end
  def create
    flash[:notice] = params.to_s
    redirect_to "/survey_template"
  end
end
