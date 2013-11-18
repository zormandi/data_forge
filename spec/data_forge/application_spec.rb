require 'spec_helper'

describe DataForge::Application do

  let(:application) { DataForge::Application.new }

  before(:each) do
    @original_stdout = $stdout
    @original_stderr = $stderr
    $stdout = StringIO.new
    $stderr = StringIO.new
  end

  after(:each) do
    $stdout = @original_stdout
    $stderr = @original_stderr
  end


  describe "#run" do
    context "when called with an empty argument list" do
      it "should exit with a suitable error message and usage information" do
        expect { application.run [] }.to raise_error(SystemExit) { |exit| exit.status.should == 1 }

        $stderr.string.should include "ERROR: no command file specified"
        $stderr.string.should include DataForge::Application::USAGE_INFORMATION
      end
    end


    context "when called with --help" do
      it "should print the usage information" do
        application.run ["--help"]

        $stdout.string.should == DataForge::Application::USAGE_INFORMATION
      end
    end


    context "when called with --version" do
      it "should print the version information" do
        application.run ["--version"]

        $stdout.string.chomp.should == "DataForge, version #{DataForge::VERSION}"
      end
    end


    context "when called with one argument" do
      it "should execute that argument as a command file" do
        application.should_receive(:execute_command_file).with("command_file.rb")

        application.run ["command_file.rb"]
      end
    end


    context "when called with multiple arguments" do
      it "should raise an error and print the usage information" do
        expect { application.run ["one", "two"] }.to raise_error(SystemExit) { |exit| exit.status.should == 1 }

        $stderr.string.should include "ERROR: executing more than one command file is currently not supported"
        $stderr.string.should include DataForge::Application::USAGE_INFORMATION
      end
    end
  end


  describe "#execute_command_file" do
    it "should raise an error if the file doesn't exist" do
      File.stub(:exists?).with("command_file.rb").and_return(false)

      expect { application.execute_command_file "command_file.rb" }.to raise_error(SystemExit) { |exit| exit.status.should == 1 }
      $stderr.string.chomp.should == "ERROR: File 'command_file.rb' does not exist"
    end

    it "should load the file if it exists" do
      File.stub(:exists?).with("command_file.rb").and_return(true)

      application.should_receive(:load).with("command_file.rb")

      application.execute_command_file "command_file.rb"
    end
  end

end
