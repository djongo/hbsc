require File.dirname(__FILE__) + '/../spec_helper'
 
describe FocusGroupsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => FocusGroup.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    FocusGroup.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    FocusGroup.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(focus_group_url(assigns[:focus_group]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => FocusGroup.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    FocusGroup.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FocusGroup.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    FocusGroup.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FocusGroup.first
    response.should redirect_to(focus_group_url(assigns[:focus_group]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    focus_group = FocusGroup.first
    delete :destroy, :id => focus_group
    response.should redirect_to(focus_groups_url)
    FocusGroup.exists?(focus_group.id).should be_false
  end
end
