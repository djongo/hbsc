require File.dirname(__FILE__) + '/../spec_helper'
 
describe VariablesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Variable.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Variable.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Variable.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(variable_url(assigns[:variable]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Variable.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Variable.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Variable.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Variable.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Variable.first
    response.should redirect_to(variable_url(assigns[:variable]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    variable = Variable.first
    delete :destroy, :id => variable
    response.should redirect_to(variables_url)
    Variable.exists?(variable.id).should be_false
  end
end
