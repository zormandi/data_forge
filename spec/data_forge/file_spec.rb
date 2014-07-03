require 'spec_helper'

describe DataForge::File do

  let(:definition) { instance_double "DataForge::File::RecordFileDefinition" }

  after do
    subject.instance_variable_set :@file_definitions, {}
  end


  describe ".register_file_definition" do
    let(:initializer_block) { lambda {} }

    context "without any options" do
      it "should register a named file definition with the specified initializer block" do
        expect(DataForge::File::RecordFileDefinition).to receive(:from_input).
                                                           with(:definition_name) { |&block| expect(block).to eq initializer_block }.
                                                           and_return definition

        subject.register_file_definition :definition_name, {}, &initializer_block

        expect(subject.file_definitions[:definition_name]).to eq definition
      end
    end


    context "with the :like option" do
      it "should copy the specified file definition" do
        subject.register_file_definition :source_definition, {}

        expect(DataForge::File::RecordFileDefinition).to receive(:from_copy).
                                                           with(subject.file_definitions[:source_definition], :definition_name) { |&block| expect(block).to eq initializer_block }.
                                                           and_return definition

        subject.register_file_definition :definition_name, like: :source_definition, &initializer_block

        expect(subject.file_definitions[:definition_name]).to eq definition
      end
    end

    it "should raise an error if an unknown definition is specified as source" do
      expect { subject.register_file_definition :def2, like: :def1 }.to raise_error "Unknown file reference 'def1'"
    end
  end


  describe ".reader_for" do
    let(:reader) { double "Reader" }

    before do
      allow(DataForge::File::RecordFileDefinition).to receive(:from_input).with(:definition_name).and_return definition
    end

    it "should return a record reader for the file with the specified name" do
      subject.register_file_definition :definition_name, {}

      expect(DataForge::File::RecordFileReader).to receive(:for).with(definition).and_return reader

      expect(subject.reader_for :definition_name).to eq reader
    end

    it "should raise an error if there is no file registered by the specified name" do
      expect { subject.reader_for :definition_name }.to raise_error "Unknown file reference 'definition_name'"
    end
  end


  describe ".writer_for" do
    let(:writer) { double "Writer" }

    before do
      allow(DataForge::File::RecordFileDefinition).to receive(:from_input).with(:definition_name).and_return definition
    end

    it "should return a record writer for the file with the specified name" do
      subject.register_file_definition :definition_name, {}

      expect(DataForge::File::RecordFileWriter).to receive(:for).with(definition).and_return writer

      expect(subject.writer_for :definition_name).to eq writer
    end

    it "should raise an error if there is no file registered by the specified name" do
      expect { subject.writer_for :definition_name }.to raise_error "Unknown file reference 'definition_name'"
    end
  end

end
