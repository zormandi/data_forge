require 'spec_helper'

describe DataForge::File::CSV::CSVRecordFileReader do

  let(:csv_file) { instance_double "CSV" }
  let(:definition) { instance_double "DataForge::File::CSV::CSVRecordFileDefinition",
                                     name: :test,
                                     file_name: "test.csv",
                                     field_names: [:field1, :field2],
                                     delimiter: "delimiter",
                                     quote: "quote",
                                     encoding: "encoding",
                                     has_header_row: true }

  subject { described_class.new definition }


  describe "#definition" do
    it "should return the file definition the writer was created for" do
      expect(subject.definition).to eq definition
    end
  end


  describe "#name" do
    it "should return the file definition's name" do
      expect(subject.name).to eq :test
    end
  end


  describe "#fields" do
    it "should return the file definition's fields" do
      expect(subject.fields).to eq [:field1, :field2]
    end
  end


  describe "#each_record" do
    context "when the CSV file has a header row" do
      it "should skip the header row and iterate through all records in the CSV file" do
        expect(CSV).to receive(:open).with("test.csv", {col_sep: "delimiter",
                                                        quote_char: "quote",
                                                        encoding: "encoding",
                                                        return_headers: false}).and_yield csv_file
        allow(csv_file).to receive(:shift).and_return(["field1", "field2"], [1, 2], [3, 4], nil)

        records = []
        subject.each_record { |record| records << record }

        expect(records).to eq [{field1: 1, field2: 2}, {field1: 3, field2: 4}]
      end
    end


    context "when the CSV file has no header row" do
      let(:definition) { instance_double "DataForge::File::CSV::CSVRecordFileDefinition",
                                         name: :test,
                                         file_name: "test.csv",
                                         field_names: [:field1, :field2],
                                         delimiter: "delimiter",
                                         quote: "quote",
                                         encoding: "encoding",
                                         has_header_row: false }

      it "should iterate through all records in the CSV file" do
        allow(CSV).to receive(:open).and_yield csv_file
        allow(csv_file).to receive(:shift).and_return([1, 2], [3, 4], nil)

        records = []
        subject.each_record { |record| records << record }

        expect(records).to eq [{field1: 1, field2: 2}, {field1: 3, field2: 4}]
      end
    end
  end

end
