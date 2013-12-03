class PresurveysController < ApplicationController
  before_filter :active_only
  #, :only => [:edit, :update]
  include SurveyControllersHelper
end
