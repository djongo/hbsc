require File.dirname(__FILE__) + '/../spec_helper'

describe Publication do
  it "should be valid" do
    Publication.new.should be_valid
  end
end
