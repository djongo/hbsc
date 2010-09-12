require File.dirname(__FILE__) + '/../spec_helper'

describe Variable do
  it "should be valid" do
    Variable.new.should be_valid
  end
end
