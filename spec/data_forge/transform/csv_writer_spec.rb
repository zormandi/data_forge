require 'spec_helper'

describe DataForge::Transform::CSVWriter do

  let(:csv_file) { double "CSV file" }
  let(:csv_writer) { Object.new.tap { |object| object.extend DataForge::Transform::CSVWriter } }

  describe "#write_csv_file" do
    it "should open a CSV file for writing and pass it the specified block" do
      block = lambda {}
      file_descriptor = DataForge::FileDescriptor.new :test
      file_descriptor.field :field1
      file_descriptor.field :field2

      CSV.should_receive(:open).with("test.csv", "w:UTF-8", { write_headers: true,
                                                              headers: [:field1, :field2] }, &block)

      csv_writer.write_csv_file file_descriptor, &block
    end
  end


  describe "#output_record_to_file" do
    it "should output specific fields of a record as a row into a CSV file" do
      fields = [:d, :a, :c]
      record = { :a => 1, :b => 2, :c => 3, :d => 4, :e => 5 }

      csv_file.should_receive(:<<).with([4, 1, 3])

      csv_writer.output_record_to_file record, fields, csv_file
    end
  end

end
