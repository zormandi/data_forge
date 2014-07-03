require 'spec_helper'

describe DataForge::File::RecordFileDefinition do
  let(:definition) { instance_double "DataForge::File::CSV::CSVRecordFileDefinition" }
  let(:initializer_block) { lambda {} }

  before do
    allow(DataForge::File::CSV::CSVRecordFileDefinition).to receive(:new).with(:test).and_return definition
  end


  describe ".from_input" do
    it "should instantiate a CSV file definition with the given name" do
      expect(DataForge::File::CSV::CSVRecordFileDefinition).to receive(:new).with(:test).and_return definition

      expect(subject.from_input :test).to eq definition
    end


    context "when there is an initializer block" do
      it "should instantiate a CSV file definition and initalize it with the initializer block" do
        expect(definition).to receive(:instance_eval) { |&block| expect(block).to be initializer_block }

        expect(subject.from_input :test, &initializer_block).to eq definition
      end
    end
  end


  describe ".from_existing" do
    it "should copy the specified file definition and customize it with the provided block" do
      source_definition = instance_double "DataForge::File::CSV::CSVRecordFileDefinition"

      expect(definition).to receive(:copy).with(source_definition).ordered
      expect(definition).to receive(:instance_eval) { |&block| expect(block).to be initializer_block }.ordered

      expect(subject.from_existing source_definition, :test, &initializer_block).to eq definition
    end
  end

end
