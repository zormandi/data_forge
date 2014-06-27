require 'spec_helper'

describe DataForge::File::RecordFileDefinition do

  describe ".from_input" do
    it "should instantiate a CSV file definition and initalize it with the initializer block" do
      definition = instance_double "DataForge::File::CSV::CSVRecordFileDefinition"
      initializer_block = lambda {}

      expect(DataForge::File::CSV::CSVRecordFileDefinition).to receive(:new).with(:test).and_return definition
      expect(definition).to receive(:instance_eval) { |&block| expect(block).to be initializer_block }

      expect(subject.from_input :test, &initializer_block).to eq definition
    end
  end

end
