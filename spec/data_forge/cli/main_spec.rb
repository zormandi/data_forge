require 'spec_helper'

describe DataForge::CLI::Main do

  let(:options) { DataForge::CLI::Options.new }
  let(:args) { double "ARGV" }
  let(:stdout) { double "STDOUT" }
  let(:stderr) { double "STDERR" }
  let(:kernel) { double "Kernel" }

  subject { described_class.new args, STDIN, stdout, stderr, kernel }

  describe "#execute!" do
    context "when there is no error" do
      before do
        allow(DataForge::CLI).to receive(:parse_options).with(args, stdout).and_return options
      end

      it "should execute the command script specified in the options" do
        options.command_script = "command_script.rb"

        expect(subject).to receive(:load).with("command_script.rb")

        subject.execute!
      end

      it "should not execute the command script if the options direct to stop execution" do
        options.execute = false

        expect(subject).not_to receive(:load)

        subject.execute!
      end
    end


    context "when an error occurs" do
      it "should output an error message in case of an error on the command line" do
        allow(DataForge::CLI).to receive(:parse_options).with(args, stdout).and_raise OptionParser::ParseError, "Invalid options"

        expect(stderr).to receive(:puts).with /^ERROR:.*Invalid options.*$/
        expect(kernel).to receive(:exit).with 1

        subject.execute!
      end

      it "should output an error message and a stack trace in case of a program error" do
        allow(DataForge::CLI).to receive(:parse_options).with(args, stdout).and_return options
        allow(subject).to receive(:load).and_raise StandardError.new("Error message").tap { |error| error.set_backtrace "stack trace" }

        expect(stderr).to receive(:puts).with "ERROR: Error message"
        expect(stderr).to receive(:puts).with ["stack trace"]
        expect(kernel).to receive(:exit).with 1

        subject.execute!
      end
    end
  end

end
