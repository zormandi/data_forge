require 'spec_helper'

describe DataForge::File::Archiver do

  let(:compression_strategy) { instance_double "DataForge::File::Archiver::CompressionStrategy::Base" }
  let(:transport_strategy) { instance_double "DataForge::File::Archiver::TransportStrategy::Base" }


  describe ".from_input" do
    it "should raise an error if no files are specified" do
      expect { described_class.from_input [], {} }.to raise_error "No files specified for `archive` command"
    end

    it "should raise an error when called with an unregistered file" do
      expect { described_class.from_input [:unregistered_file], {} }.to raise_error DataForge::File::UnknownDefinitionError
    end

    it "should raise an error if no archive directory was specified" do
      stub_definition :file1, file_name: "file1.csv"

      expect { described_class.from_input [:file1], {} }.to raise_error "Missing :to directive for `archive` command"
    end

    context "when there is no error" do
      before do
        stub_definition :file1, file_name: "file1.csv"
        stub_definition :file2, file_name: "file2.csv"
      end

      it "should return an Archiver for the specified files with a compression and transport strategy based on the options specified" do
        allow(DataForge::File::Archiver::CompressionStrategy).to receive(:from_options).with(:gzip, "archive.tar").and_return compression_strategy
        allow(DataForge::File::Archiver::TransportStrategy).to receive(:from_destination_uri).with("archive_dir").and_return transport_strategy
        allow(described_class).to receive(:new).with(["file1.csv", "file2.csv"],
                                                     compression_strategy,
                                                     transport_strategy).and_return("archiver")

        expect(described_class.from_input [:file1, :file2], {to: "archive_dir",
                                                             as: "archive.tar",
                                                             compress_with: :gzip}).to eq "archiver"
      end

      it "should use the first file's name as the archive name and use no compression by default" do
        expect(DataForge::File::Archiver::CompressionStrategy).to receive(:from_options).with(:nothing, "file1.csv")

        described_class.from_input [:file1, :file2], to: "archive_dir"
      end
    end
  end


  describe "#execute" do

    let(:file1) { stub_definition :file1, file_name: "first.csv" }
    let(:file2) { stub_definition :file2, file_name: "second.csv" }


    it "should create the archive directory and execute the archiver transport strategy for all files" do
      expect(compression_strategy).to receive(:execute).with(["first.csv", "second.csv"]).and_return "archive.tar"
      expect(transport_strategy).to receive(:execute).with("archive.tar")

      described_class.new(["first.csv", "second.csv"], compression_strategy, transport_strategy).execute
    end
  end

end
