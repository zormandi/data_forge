require 'spec_helper'

describe DataForge do

  it "should have a version number" do
    expect(DataForge::VERSION).not_to be_nil
  end


  describe "#application" do
    it "should return an Application instance" do
      expect(DataForge.application).to be_a DataForge::Application
    end

    it "should return a singleton instance" do
      expect(DataForge.application).to equal DataForge.application
    end
  end

end
