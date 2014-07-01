require 'spec_helper'

describe DataForge::CLI do
  let(:options) { DataForge::CLI::Options.new }
  let(:args) { double "ARGV" }
  let(:stdout) { double "STDOUT" }

  before do
    allow(DataForge::CLI::Options).to receive(:parse).with(args, stdout).and_return options
  end

  after do
    subject.instance_variable_set :@command_script, nil
    subject.instance_variable_set :@user_params, nil
  end


  describe ".parse_options" do
    it "should return the command line options parsed into an Options object" do
      expect(subject.parse_options args, stdout).to eq options
    end
  end


  describe ".command_script" do
    it "should be nil by default" do
      expect(subject.command_script).to be_nil
    end

    it "should return the command script specified in options that were parsed" do
      options.command_script = "command_script.rb"

      subject.parse_options args, stdout

      expect(subject.command_script).to eq "command_script.rb"
    end
  end


  describe ".user_params" do
    it "should be nil by default" do
      expect(subject.user_params).to be_nil
    end

    it "should return the user-defined parameters specified in options that were parsed" do
      options.user_params = {p1: "v1", p2: "v2"}

      subject.parse_options args, stdout

      expect(subject.user_params).to eq(p1: "v1", p2: "v2")
    end
  end

end
