class CollegesController < ApplicationController
  before_filter :admin_only

  def index
    @all_colleges = College.all
  end

  def new
    @college_fields = College.new(params[:college])
  end

  def create
    begin
      College.create!(params[:college])
      flash[:notice] = "College successfully created."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Fields cannot be left blank."
      redirect_to new_college_path(:college => params[:college])
    end
  end

  def edit
    @college_fields = College.find(params[:id])
  end

  def update
    begin
      College.find(params[:id]).update_attributes!(params[:school])
      flash[:notice] = "College successfully updated."
      redirect_to portal_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Fields cannot be left blank."
      redirect_to edit_college_path(:id => params[:id], :school => params[:school])
    end
  end
end