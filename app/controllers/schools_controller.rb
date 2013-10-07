class SchoolsController < ApplicationController
  before_filter :admin_only

  def index
    @all_schools = School.all
  end

  def new
    @school_fields = School.new(params[:school])
  end

  def create
    begin
      School.create!(params[:school])
      flash[:notice] = "School successfully created."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Fields cannot be left blank."
      redirect_to new_school_path(:school => params[:school])
    end
  end

  def edit
    @school_fields = School.find(params[:id])
  end

  def update
    begin
      School.find(params[:id]).update_attributes!(params[:school])
      flash[:notice] = "School successfully updated."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Fields cannot be left blank."
      redirect_to edit_school_path(:id => params[:id], :school => params[:school])
    end
  end
end
