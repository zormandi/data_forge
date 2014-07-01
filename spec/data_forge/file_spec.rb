require 'spec_helper'

describe DataForge::File do

  let(:definition) { instance_double "DataForge::File::RecordFileDefinition" }

  before do
    allow(DataForge::File::RecordFileDefinition).to receive(:from_input).with(:definition_name).and_return definition
  end

  after do
    subject.instance_variable_set :@file_definitions, {}
  end


  describe ".reader_for" do
    let(:reader) { double "Reader" }

    it "should return a record reader for the file with the specified name" do
      subject.register_file_definition :definition_name

      expect(DataForge::File::RecordFileReader).to receive(:for).with(definition).and_return reader

      expect(subject.reader_for :definition_name).to eq reader
    end

    it "should raise an error if there is no file registered by the specified name" do
      expect { subject.reader_for :definition_name }.to raise_error "Unknown file reference 'definition_name'"
    end
  end


  describe ".writer_for" do
    let(:writer) { double "Writer" }

    it "should return a record writer for the file with the specified name" do
      subject.register_file_definition :definition_name

      expect(DataForge::File::RecordFileWriter).to receive(:for).with(definition).and_return writer

      expect(subject.writer_for :definition_name).to eq writer
    end

    it "should raise an error if there is no file registered by the specified name" do
      expect { subject.writer_for :definition_name }.to raise_error "Unknown file reference 'definition_name'"
    end
  end

end
