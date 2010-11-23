require File.dirname(__FILE__) + '/../spec_helper'
 
describe TargetJournalsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => TargetJournal.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    TargetJournal.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    TargetJournal.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(target_journal_url(assigns[:target_journal]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => TargetJournal.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    TargetJournal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TargetJournal.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    TargetJournal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TargetJournal.first
    response.should redirect_to(target_journal_url(assigns[:target_journal]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    target_journal = TargetJournal.first
    delete :destroy, :id => target_journal
    response.should redirect_to(target_journals_url)
    TargetJournal.exists?(target_journal.id).should be_false
  end
end
