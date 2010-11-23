require File.dirname(__FILE__) + '/../spec_helper'

describe Journal do
  it "should be valid" do
    Journal.new.should be_valid
  end
end
