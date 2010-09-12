require File.dirname(__FILE__) + '/../spec_helper'

describe Language do
  it "should be valid" do
    Language.new.should be_valid
  end
end
