require 'spec_helper'

describe DataForge::Transformation::RubyTransformation do
  let(:transformation_block) { lambda {} }

  describe ".from_input" do
    let(:transformation) { instance_double described_class.name }
    let(:reader) { instance_double "DataForge::File::RecordFileReader", name: :source, fields: [:field1, :field2, :field3] }
    let(:source_writer) { instance_double "DataForge::File::RecordFileWriter" }
    let(:target_writer) { instance_double "DataForge::File::RecordFileWriter" }
    let(:other_target_writer) { instance_double "DataForge::File::RecordFileWriter" }

    before do
      allow(DataForge::File).to receive(:reader_for).with(:source).and_return reader
      allow(DataForge::File).to receive(:writer_for).with(:source).and_return source_writer
      allow(DataForge::File).to receive(:writer_for).with(:target).and_return target_writer
      allow(DataForge::File).to receive(:writer_for).with(:other_target).and_return other_target_writer
    end


    context "when only the source is specified" do
      it "should return a RubyTransformation with a single writer for the same file" do
        allow(described_class).to receive(:new)
                                  .with(reader, [source_writer]) { |&block| expect(block).to eq transformation_block }
                                  .and_return transformation

        expect(described_class.from_input :source, &transformation_block).to eq transformation
      end
    end


    context "when a single writer is specified" do
      it "should return a RubyTransformation with the specified writer" do
        allow(described_class).to receive(:new).with(reader, [target_writer]).and_return transformation

        expect(described_class.from_input :source, into: :target, &transformation_block).to eq transformation
      end
    end


    context "when multiple writers are specified" do
      it "should return a RubyTransformation with all specified writers" do
        allow(described_class).to receive(:new).with(reader, [target_writer, other_target_writer]).and_return transformation

        expect(described_class.from_input :source, into: [:target, :other_target], &transformation_block).to eq transformation
      end
    end
  end


  describe "#execute" do
    subject { described_class.new reader, writers, &transformation_block }

    let(:writers) { [mock_writer] }
    let(:reader) { stub_reader_with_records [{f1: "a", f2: "b"},
                                             {f1: "c", f2: "d"},
                                             {f1: "e", f2: "f"}] }

    it "should write only the first instance of each source record to the writer" do
      context = instance_double "DataForge::Transformation::RubyTransformationContext"
      expect(DataForge::Transformation::RubyTransformationContext).to receive(:new).with(writers).and_return context

      expect(context).to receive(:instance_exec).with(f1: "a", f2: "b") { |&block| expect(block).to eq transformation_block }
      expect(context).to receive(:instance_exec).with(f1: "c", f2: "d") { |&block| expect(block).to eq transformation_block }
      expect(context).to receive(:instance_exec).with(f1: "e", f2: "f") { |&block| expect(block).to eq transformation_block }

      subject.execute
    end
  end

end
