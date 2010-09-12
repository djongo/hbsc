class VariablesController < ApplicationController
  filter_resource_access
  
  def index
    @variables = Variable.all
  end
  
  def show
#    @variable = Variable.find(params[:id])
  end
  
  def new
#    @variable = Variable.new
  end
  
  def create
#    @variable = Variable.new(params[:variable])
    if @variable.save
      flash[:notice] = "Successfully created variable."
      redirect_to @variable
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @variable = Variable.find(params[:id])
  end
  
  def update
#    @variable = Variable.find(params[:id])
    if @variable.update_attributes(params[:variable])
      flash[:notice] = "Successfully updated variable."
      redirect_to @variable
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @variable = Variable.find(params[:id])
    @variable.destroy
    flash[:notice] = "Successfully destroyed variable."
    redirect_to variables_url
  end
end
