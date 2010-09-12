class PopulationsController < ApplicationController
  filter_resource_access

  def index
    @populations = Population.all
  end
  
  def show
#    @population = Population.find(params[:id])
  end
  
  def new
#    @population = Population.new
  end
  
  def create
#    @population = Population.new(params[:population])
    if @population.save
      flash[:notice] = "Successfully created population."
      redirect_to @population
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @population = Population.find(params[:id])
  end
  
  def update
#    @population = Population.find(params[:id])
    if @population.update_attributes(params[:population])
      flash[:notice] = "Successfully updated population."
      redirect_to @population
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @population = Population.find(params[:id])
    @population.destroy
    flash[:notice] = "Successfully destroyed population."
    redirect_to populations_url
  end
end
