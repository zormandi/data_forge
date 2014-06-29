require 'spec_helper'

describe DataForge::CLI::Options do

  let(:stdout) { StringIO.new }
  subject { DataForge::CLI::Options }

  describe ".parse" do
    context "when parsing the command file parameter" do
      it "should accept a single command file parameter" do
        options = subject.parse(%w[command_file.rb])

        expect(options.command_file).to eq "command_file.rb"
      end

      it "should raise an error if no command file is specified" do
        expect { subject.parse(%w[]) }.to raise_error "No command file specified"
      end

      it "should raise an error if there is more than one command file specified" do
        expect { subject.parse(%w[command_file1.rb command_file2.rb]) }.to raise_error "More than one command file specified"
      end
    end


    context "when parsing the --help switch" do
      it "should print the help information" do
        subject.parse(%w[--help], stdout)

        expect(stdout.string).to include "Usage: [bundle exec] forge [options] command_script.rb"
      end
    end


    context "when parsing the --version switch" do
      it "should print the version" do
        subject.parse(%w[--version], stdout)

        expect(stdout.string).to match /DataForge, version \d+(\.\d+)*/
      end
    end


    context "when parsing user-defined parameters" do
      it "should accept a name-value pair as a parameter with the -U switch" do
        options = subject.parse(%w[-Ucustomer=test command_file.rb])

        expect(options.user_params).to eq(customer: "test")
      end

      it "should accept multiple user-defined parameters" do
        options = subject.parse(%w[-Ucustomer=test -Udata_file=items.csv command_file.rb])

        expect(options.user_params).to eq(customer: "test", data_file: "items.csv")
      end
    end


    it "should raise an error if an unknown option is specified" do
      expect { subject.parse(%w[--unknown]) }.to raise_error OptionParser::InvalidOption
    end
  end

end
