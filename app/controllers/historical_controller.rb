class HistoricalController < ApplicationController
  before_filter :admin_only
  include SchoolsHelper

  def new
    @schools = get_school_names
    @times = Course.all.collect { |t| ["#{t.semester}", t.id] }.uniq.sort
  end

  def create
    @chosen_schools = School.find_by_id(params[:checked_schools])
    chosen_times = params[:checked_times]
  end
end
