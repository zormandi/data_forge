require 'spec_helper'

describe DataForge::Transform::CSVWriter do

  let(:csv_file) { double "CSV file" }
  let(:csv_writer) { Object.new.tap { |object| object.extend DataForge::Transform::CSVWriter } }

  describe "#write_csv_file" do
    let(:file_descriptor1) { double "FileDescriptor",
                                    name: :test1,
                                    delimiter: "delimiter1",
                                    quote: "quote1",
                                    encoding: "encoding1",
                                    has_header: true,
                                    field_names: [:field11, :field12] }
    let(:file_descriptor2) { double "FileDescriptor",
                                    name: :test2,
                                    delimiter: "delimiter2",
                                    quote: "quote2",
                                    encoding: "encoding2",
                                    has_header: true,
                                    field_names: [:field21, :field22] }
    let(:file1) { double "CSV file" }
    let(:file2) { double "CSV file" }

    it "should open all CSV files for writing, yield them to the specified block and close them" do
      CSV.should_receive(:open).with("test1.csv", "w", { col_sep: "delimiter1",
                                                         quote_char: "quote1",
                                                         encoding: "encoding1",
                                                         write_headers: true,
                                                         headers: [:field11, :field12] }).and_return file1
      CSV.should_receive(:open).with("test2.csv", "w", { col_sep: "delimiter2",
                                                         quote_char: "quote2",
                                                         encoding: "encoding2",
                                                         write_headers: true,
                                                         headers: [:field21, :field22] }).and_return file2
      file1.should_receive :close
      file2.should_receive :close

      expect { |block| csv_writer.write_csv_file [file_descriptor1, file_descriptor2], &block }.to yield_with_args [file1, file2]
    end

    context "when a file has no header" do
      it "should open a CSV file with no header row" do
        file_descriptor1.stub has_header: false

        CSV.should_receive(:open).with("test1.csv", "w", { col_sep: "delimiter1",
                                                           quote_char: "quote1",
                                                           encoding: "encoding1",
                                                           write_headers: false }).and_return file1.as_null_object

        csv_writer.write_csv_file([file_descriptor1]) {}
      end
    end

    context "when the block raises an error" do
      it "should ensure that all files are closed" do
        CSV.stub(:open).and_return(file1, file2)

        file1.should_receive :close
        file2.should_receive :close

        begin
          csv_writer.write_csv_file([file_descriptor1, file_descriptor2]) { raise "error" }
        rescue
        end
      end
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
