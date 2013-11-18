require 'spec_helper'

describe DataForge do
  it "should have a version number" do
    DataForge::VERSION.should_not be_nil
  end


  describe "#application" do
    it "should return an Application instance" do
      DataForge.application.should be_a DataForge::Application
    end

    it "should return a singleton instance" do
      DataForge.application.should equal DataForge.application
    end
  end
end
