class PostsurveysController < ApplicationController
  before_filter :active_only
  include SurveyControllersHelper
end
