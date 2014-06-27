require 'spec_helper'

describe DataForge::File::RecordFileWriter do

  describe ".for" do
    it "should return a record writer for the specified file definition" do
      definition = instance_double DataForge::File::CSV::CSVRecordFileDefinition

      expect(DataForge::File::CSV::CSVRecordFileWriter).to receive(:new).with(definition).and_return "record writer"

      expect(described_class.for definition).to eq "record writer"
    end
  end

end
