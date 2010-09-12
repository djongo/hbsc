class CountryTeamsController < ApplicationController
  filter_resource_access
  
  def index
    @country_teams = CountryTeam.all
  end
  
  def show
#    @country_team = CountryTeam.find(params[:id])
  end
  
  def new
#    @country_team = CountryTeam.new
  end
  
  def create
#    @country_team = CountryTeam.new(params[:country_team])
    if @country_team.save
      flash[:notice] = "Successfully created country team."
      redirect_to @country_team
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @country_team = CountryTeam.find(params[:id])
  end
  
  def update
#    @country_team = CountryTeam.find(params[:id])
    if @country_team.update_attributes(params[:country_team])
      flash[:notice] = "Successfully updated country team."
      redirect_to @country_team
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @country_team = CountryTeam.find(params[:id])
    @country_team.destroy
    flash[:notice] = "Successfully destroyed country team."
    redirect_to country_teams_url
  end
end
