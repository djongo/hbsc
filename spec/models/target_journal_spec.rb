require File.dirname(__FILE__) + '/../spec_helper'

describe TargetJournal do
  it "should be valid" do
    TargetJournal.new.should be_valid
  end
end
