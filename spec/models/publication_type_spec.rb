require File.dirname(__FILE__) + '/../spec_helper'

describe PublicationType do
  it "should be valid" do
    PublicationType.new.should be_valid
  end
end
