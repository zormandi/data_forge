require 'spec_helper'

describe DataForge::File::Archiver do

  let(:strategy) { instance_double "DataForge::File::Archiver::Strategy" }


  describe ".from_input" do
    it "should raise an error if no files are specified" do
      expect { described_class.from_input [], {} }.to raise_error "No files specified for `archive` command"
    end

    it "should raise an error when called with an unregistered file" do
      expect { described_class.from_input [:unregistered_file], {} }.to raise_error DataForge::File::UnknownDefinitionError
    end

    it "should return an Archiver for the specified files with a strategy based on the options specified" do
      archiver = instance_double described_class.name
      file1, file2 = stub_definitions :file1, :file2

      allow(DataForge::File::Archiver::Strategy).to receive(:from_options).with({to: "archive_dir"}).and_return strategy
      allow(described_class).to receive(:new).with([file1, file2], strategy).and_return(archiver)

      expect(described_class.from_input [:file1, :file2], {to: "archive_dir"}).to eq archiver
    end
  end


  describe "#execute" do

    let(:file1) { stub_definition :file1, file_name: "first.csv" }
    let(:file2) { stub_definition :file2, file_name: "second.csv" }

    before do
      allow(strategy).to receive(:archive_directory).and_return "archives"
    end


    it "should create the archive directory and execute the archiver strategy for all files" do
      expect(FileUtils).to receive(:mkdir_p).with("archives")
      expect(strategy).to receive(:execute).with(["first.csv", "second.csv"])

      described_class.new([file1, file2], strategy).execute
    end
  end

end
