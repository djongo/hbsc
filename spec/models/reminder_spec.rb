require File.dirname(__FILE__) + '/../spec_helper'

describe Reminder do
  it "should be valid" do
    Reminder.new.should be_valid
  end
end
