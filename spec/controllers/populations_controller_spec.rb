require File.dirname(__FILE__) + '/../spec_helper'
 
describe PopulationsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Population.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Population.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Population.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(population_url(assigns[:population]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Population.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Population.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Population.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Population.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Population.first
    response.should redirect_to(population_url(assigns[:population]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    population = Population.first
    delete :destroy, :id => population
    response.should redirect_to(populations_url)
    Population.exists?(population.id).should be_false
  end
end
