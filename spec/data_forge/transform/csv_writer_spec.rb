require 'spec_helper'

describe DataForge::Transform::CSVWriter do

  let(:csv_file) { double "CSV file" }
  let(:csv_writer) { Object.new.tap { |object| object.extend DataForge::Transform::CSVWriter } }

  describe "#write_csv_file" do
    it "should open a CSV file for writing, yield it to a block and close it" do
      file_descriptor = DataForge::FileDescriptor.new :test
      file_descriptor.field :field1
      file_descriptor.field :field2

      CSV.should_receive(:open).with("test.csv", "w:UTF-8", { write_headers: true,
                                                              headers: [:field1, :field2] }).and_return csv_file
      csv_file.should_receive :close

      expect { |block| csv_writer.write_csv_file(file_descriptor, &block) }.to yield_with_args(csv_file)
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
