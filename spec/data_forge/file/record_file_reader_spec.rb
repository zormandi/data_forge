require 'spec_helper'

describe DataForge::File::RecordFileReader do

  describe ".for" do
    it "should return a record reader for the specified file definition" do
      definition = instance_double DataForge::File::CSV::CSVRecordFileDefinition

      expect(DataForge::File::CSV::CSVRecordFileReader).to receive(:new).with(definition).and_return "record reader"

      expect(described_class.for definition).to eq "record reader"
    end
  end

end
