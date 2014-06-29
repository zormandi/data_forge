require 'spec_helper'

describe DataForge::CLI::Main do

  let(:options) { DataForge::CLI::Options.new }
  let(:args) { double "ARGV" }
  let(:stdout) { double "STDOUT" }
  let(:stderr) { double "STDERR" }
  let(:kernel) { double "Kernel" }

  subject { described_class.new args, STDIN, stdout, stderr, kernel }

  before do
    allow(DataForge::CLI::Options).to receive(:parse).with(args, stdout).and_return options
  end


  describe "#execute!" do
    it "should execute the command file specified in the options" do
      options.command_file = "command_file.rb"

      expect(subject).to receive(:load).with("command_file.rb")

      subject.execute!
    end

    it "should not execute the command file if the options direct to stop execution" do
      options.execute = false

      expect(subject).not_to receive(:load)

      subject.execute!
    end

    it "should output an error message in case of an error" do
      allow(subject).to receive(:load).and_raise "Error message"

      expect(stderr).to receive(:puts).with "ERROR: Error message"
      expect(kernel).to receive(:exit).with 1

      subject.execute!
    end
  end

end
