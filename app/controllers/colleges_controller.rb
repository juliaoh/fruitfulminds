class CollegesController < ApplicationController
  before_filter :admin_only

  def index
    @all_colleges = College.all(:order => :name)
  end

  def new
    @college_fields = College.new(params[:college])
  end

  def create
    begin
      College.create!(params[:college])
      flash[:notice] = "Code"
      flash[:notice] = "Successfully created college."
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
      College.find(params[:id]).update_attributes!(params[:college])
      flash[:notice] = "Code"
      flash[:notice] = "Successfully updated college."
      redirect_to colleges_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Fields cannot be left blank."
      redirect_to edit_college_path(:id => params[:id], :college => params[:college])
    end
  end

  def destroy
    @college = College.find(params[:id])
    @college.destroy
    flash[:notice] = "Successfully deleted college."
    redirect_to colleges_path
  end
end
