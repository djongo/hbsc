class PublicationTypesController < ApplicationController
  filter_resource_access

  def index
    @publication_types = PublicationType.all
  end
  
  def show
#    @publication_type = PublicationType.find(params[:id])
  end
  
  def new
#    @publication_type = PublicationType.new
  end
  
  def create
#    @publication_type = PublicationType.new(params[:publication_type])
    if @publication_type.save
      flash[:notice] = "Successfully created publication type."
      redirect_to @publication_type
    else
      render :action => 'new'
    end
  end
  
  def edit
#    @publication_type = PublicationType.find(params[:id])
  end
  
  def update
#    @publication_type = PublicationType.find(params[:id])
    if @publication_type.update_attributes(params[:publication_type])
      flash[:notice] = "Successfully updated publication type."
      redirect_to @publication_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
#    @publication_type = PublicationType.find(params[:id])
    @publication_type.destroy
    flash[:notice] = "Successfully destroyed publication type."
    redirect_to publication_types_url
  end
end
