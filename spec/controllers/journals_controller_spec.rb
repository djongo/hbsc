require File.dirname(__FILE__) + '/../spec_helper'
 
describe JournalsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Journal.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Journal.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Journal.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(journal_url(assigns[:journal]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Journal.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Journal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Journal.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Journal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Journal.first
    response.should redirect_to(journal_url(assigns[:journal]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    journal = Journal.first
    delete :destroy, :id => journal
    response.should redirect_to(journals_url)
    Journal.exists?(journal.id).should be_false
  end
end
