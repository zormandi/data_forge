require 'spec_helper'

describe DataForge::Shell do
  let(:status) { instance_double "Process::Status" }

  before do
    allow(Open3).to receive(:capture3).with("shell_command").and_return(["out", "err", status])
  end


  describe ".exec" do
    it "should execute the shell command and return the standard output, error and status fields" do
      expect(subject.exec "shell_command").to eq ["out", "err", status]
    end
  end


  describe ".exec!" do
    it "should execute the command and return the results" do
      allow(status).to receive(:success?).and_return true

      expect(subject.exec! "shell_command").to eq ["out", "err", status]
    end

    it "should raise an error if the command failed" do
      allow(status).to receive_messages(success?: false,
                                        exitstatus: 123)

      expect(DataForge::Shell::CommandError).to receive(:new).with("out", "err", 123).and_return "shell error"

      expect { subject.exec! "shell_command" }.to raise_error "shell error"
    end
  end

end
