require 'spec_helper'

describe DataForge::Transformation::Filter do

  describe ".from_input" do
    let(:filter) { instance_double described_class.name }
    let(:filter_block) { lambda {} }
    let(:reader) { instance_double "DataForge::File::RecordFileReader", name: :source, fields: [:field1, :field2, :field3] }
    let(:source_writer) { instance_double "DataForge::File::RecordFileWriter" }
    let(:target_writer) { instance_double "DataForge::File::RecordFileWriter" }

    before do
      allow(DataForge::File).to receive(:reader_for).with(:source).and_return reader
      allow(DataForge::File).to receive(:writer_for).with(:source).and_return source_writer
      allow(DataForge::File).to receive(:writer_for).with(:target).and_return target_writer
    end


    context "when only the source is specified" do
      it "should return a Filter with a writer for the same file" do
        allow(described_class).to receive(:new)
                                  .with(reader, source_writer) { |&block| expect(block).to eq filter_block }
                                  .and_return filter

        expect(described_class.from_input :source, &filter_block).to eq filter
      end
    end


    context "when a target file is specified" do
      it "should return a Filter with the specified writer" do
        allow(described_class).to receive(:new).with(reader, target_writer).and_return filter

        expect(described_class.from_input :source, into: :target, &filter_block).to eq filter
      end
    end
  end


  describe "#execute" do
    subject { described_class.new reader, writer do |record| record[:f1] == 3 end }

    let(:writer) { mock_writer }
    let(:reader) { stub_reader_with_records [{f1: 1, f2: 9},
                                             {f1: 2, f2: 8},
                                             {f1: 3, f2: 7},
                                             {f1: 4, f2: 6},
                                             {f1: 5, f2: 5}] }

    it "should write only those records that evaluate to true by the filter block" do
      expect(writer).to receive(:write).with(f1: 3, f2: 7)

      subject.execute
    end
  end

end
