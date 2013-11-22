require 'spec_helper'

describe DataForge::Transform::CSVReader do

  let(:csv_file) { double "CSV file" }
  let(:csv_reader) { Object.new.tap { |object| object.extend DataForge::Transform::CSVReader } }

  describe "#read_csv_file_by_line" do
    it "should open a CSV file for reading, skip its first row and iterate through the rest" do
      file_descriptor = DataForge::FileDescriptor.new :test
      block = lambda {}

      CSV.should_receive(:open).with("test.csv", { return_headers: false }).and_yield csv_file
      csv_file.should_receive :shift
      csv_file.should_receive(:each).with(&block)

      csv_reader.read_csv_file_by_line(file_descriptor, &block)
    end
  end


  describe "#csv_record_from_row" do
    it "should return a Hash with the specified fields as keys and the take the values from the given row" do
      csv_reader.csv_record_from_row([1, 2, 3], [:a, :b, :c]).should == { a: 1, b: 2, c: 3 }
    end
  end

end
