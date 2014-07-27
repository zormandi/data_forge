require 'spec_helper'

describe DataForge::File::Remover do

  describe ".from_input" do
    it "should raise an error if no files are specified" do
      expect { described_class.from_input [] }.to raise_error "No files specified for `trash` command"
    end

    it "should raise an error when called with an unregistered file" do
      expect { described_class.from_input [:unregistered_file] }.to raise_error DataForge::File::UnknownDefinitionError
    end

    it "should return a Remover object for the specified files" do
      remover = instance_double described_class.name
      file1, file2 = stub_definitions :file1, :file2

      allow(described_class).to receive(:new).with([file1, file2]).and_return(remover)

      expect(described_class.from_input [:file1, :file2]).to eq remover
    end
  end


  describe "#execute" do
    it "should delete all files belonging to the specified file definitions" do
      file1 = stub_definition :file1, file_name: "first.csv"
      file2 = stub_definition :file2, file_name: "second.csv"

      expect(File).to receive(:delete).with("first.csv", "second.csv")

      described_class.new([file1, file2]).execute
    end
  end

end
