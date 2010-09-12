require File.dirname(__FILE__) + '/../spec_helper'

describe FocusGroup do
  it "should be valid" do
    FocusGroup.new.should be_valid
  end
end
