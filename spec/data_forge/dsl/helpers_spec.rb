require 'spec_helper'

describe DataForge::DSL::Helpers do

  subject { Object.new.extend described_class }

  describe "PARAMS" do
    it "should return the user parameters passed in through the CLI" do
      expect(DataForge::CLI).to receive(:user_params).and_return "user defined parameters"

      expect(subject.instance_eval { PARAMS }).to eq "user defined parameters"
    end
  end


  describe "COMMAND_SCRIPT" do
    it "should return the command script that is currently executing" do
      expect(DataForge::CLI).to receive(:command_script).and_return "command_script.rb"

      expect(subject.instance_eval { COMMAND_SCRIPT }).to eq "command_script.rb"
    end
  end

end
