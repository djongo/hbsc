require File.dirname(__FILE__) + '/../spec_helper'

describe CountryTeam do
  it "should be valid" do
    CountryTeam.new.should be_valid
  end
end
