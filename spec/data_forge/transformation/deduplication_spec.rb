require 'spec_helper'

describe DataForge::Transformation::Deduplication do

  describe ".from_input" do
    let(:deduplication) { instance_double described_class.name }
    let(:reader) { instance_double "DataForge::File::RecordFileReader", name: :source, fields: [:field1, :field2, :field3] }
    let(:source_writer) { instance_double "DataForge::File::RecordFileWriter" }
    let(:target_writer) { instance_double "DataForge::File::RecordFileWriter" }

    before do
      allow(DataForge::File).to receive(:reader_for).with(:source).and_return reader
      allow(DataForge::File).to receive(:writer_for).with(:source).and_return source_writer
      allow(DataForge::File).to receive(:writer_for).with(:target).and_return target_writer
    end


    context "when only the source is specified" do
      it "should return a Deduplication with a writer for the same file" do
        allow(described_class).to receive(:new).with(reader, source_writer, anything).and_return deduplication

        expect(described_class.from_input :source).to eq deduplication
      end

      it "should return a Deduplication using all the fields of the source" do
        allow(described_class).to receive(:new).with(reader, anything, [:field1, :field2, :field3]).and_return deduplication

        expect(described_class.from_input :source).to eq deduplication
      end
    end


    context "when a target file is specified" do
      it "should return a Deduplication with the specified writer" do
        allow(described_class).to receive(:new).with(reader, target_writer, anything).and_return deduplication

        expect(described_class.from_input :source, into: :target).to eq deduplication
      end
    end


    context "when the unique fields are specified" do
      it "should return a Deduplication using the specified field, if there is only one" do
        allow(described_class).to receive(:new).with(anything, anything, [:field1]).and_return deduplication

        expect(described_class.from_input :source, using: :field1).to eq deduplication
      end

      it "should return a Deduplication using all specified fields, if there is more than one" do
        allow(described_class).to receive(:new).with(anything, anything, [:field1, :field2]).and_return deduplication

        expect(described_class.from_input :source, using: [:field1, :field2]).to eq deduplication
      end
    end
  end

end
