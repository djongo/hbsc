require File.dirname(__FILE__) + '/../spec_helper'

describe Population do
  it "should be valid" do
    Population.new.should be_valid
  end
end
