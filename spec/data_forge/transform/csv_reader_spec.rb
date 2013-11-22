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

end
