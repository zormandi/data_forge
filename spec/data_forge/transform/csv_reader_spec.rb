require 'spec_helper'

describe DataForge::Transform::CSVReader do

  let(:csv_file) { double "CSV file" }
  let(:csv_reader) { Object.new.tap { |object| object.extend DataForge::Transform::CSVReader } }

  describe "#read_records_from_csv_file" do
    let(:file_descriptor) { double "FileDescriptor",
                                   name: :test,
                                   field_names: [:field1, :field2],
                                   delimiter: "delimiter",
                                   quote: "quote",
                                   encoding: "encoding",
                                   has_header: true }
    let(:block) { lambda {} }

    context "when the file has a header" do
      it "should open a CSV file for reading, skip its first row and iterate through the rest" do
        records = []
        expect(CSV).to receive(:open).with("test.csv", {col_sep: "delimiter",
                                                        quote_char: "quote",
                                                        encoding: "encoding",
                                                        return_headers: false}).and_yield csv_file
        allow(csv_file).to receive(:shift).and_return(["f1", "f2"], [1, 2], [3, 4], nil)

        csv_reader.read_records_from_csv_file(file_descriptor) { |record| records << record }

        expect(records).to eq [{field1: 1, field2: 2}, {field1: 3, field2: 4}]
      end
    end

    context "when the file has no header" do
      it "should not skip the first row" do
        records = []
        allow(CSV).to receive(:open).and_yield csv_file
        allow(file_descriptor).to receive(:has_header).and_return(false)
        allow(csv_file).to receive(:shift).and_return([1, 2], [3, 4], nil)

        csv_reader.read_records_from_csv_file(file_descriptor) { |record| records << record }

        expect(records).to eq [{field1: 1, field2: 2}, {field1: 3, field2: 4}]
      end
    end
  end

end
