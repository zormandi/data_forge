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
        expect { application.run [] }.to raise_error(SystemExit) { |exit| expect(exit.status).to eq 1 }

        expect($stderr.string).to include "ERROR: no command file specified"
        expect($stderr.string).to include DataForge::Application::USAGE_INFORMATION
      end
    end


    context "when called with --help" do
      it "should print the usage information" do
        application.run ["--help"]

        expect($stdout.string).to eq DataForge::Application::USAGE_INFORMATION
      end
    end


    context "when called with --version" do
      it "should print the version information" do
        application.run ["--version"]

        expect($stdout.string.chomp).to eq "DataForge, version #{DataForge::VERSION}"
      end
    end


    context "when called with one argument" do
      it "should execute that argument as a command file" do
        expect(application).to receive(:execute_command_file).with("command_file.rb")

        application.run ["command_file.rb"]
      end
    end


    context "when called with multiple arguments" do
      it "should raise an error and print the usage information" do
        expect { application.run ["one", "two"] }.to raise_error(SystemExit) { |exit| expect(exit.status).to eq 1 }

        expect($stderr.string).to include "ERROR: executing more than one command file is currently not supported"
        expect($stderr.string).to include DataForge::Application::USAGE_INFORMATION
      end
    end
  end


  describe "#execute_command_file" do
    it "should raise an error if the file doesn't exist" do
      allow(File).to receive(:exists?).with("command_file.rb").and_return(false)

      expect { application.execute_command_file "command_file.rb" }.to raise_error(SystemExit) { |exit| expect(exit.status).to eq 1 }
      expect($stderr.string.chomp).to eq "ERROR: File 'command_file.rb' does not exist"
    end

    it "should load the file if it exists" do
      allow(File).to receive(:exists?).with("command_file.rb").and_return(true)

      expect(application).to receive(:load).with("command_file.rb")

      application.execute_command_file "command_file.rb"
    end
  end

end
