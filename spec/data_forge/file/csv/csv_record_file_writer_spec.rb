require 'spec_helper'

describe DataForge::File::CSV::CSVRecordFileWriter do

  let(:csv_file) { instance_double "CSV" }
  let(:definition) { instance_double "DataForge::File::CSV::CSVRecordFileDefinition",
                                     name: :test,
                                     file_name: "test.csv",
                                     field_names: [:field1, :field2, :field3],
                                     delimiter: "delimiter",
                                     quote: "quote",
                                     encoding: "encoding",
                                     has_header_row: true }

  subject { described_class.new definition }

  before do
    allow(Dir::Tmpname).to receive(:make_tmpname).with(["test", ".csv"], 1).and_return("generated_tempname.csv")
    allow(CSV).to receive(:open).and_return csv_file
  end


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
      expect(subject.fields).to eq [:field1, :field2, :field3]
    end
  end


  describe "#open" do
    it "should open a CSV file for writing with a temporary filename" do
      expect(CSV).to receive(:open).with("generated_tempname.csv", "w", anything)

      subject.open
    end


    it "should use the file definition's settings as CSV options" do
      expect(CSV).to receive(:open).with(anything, "w", {col_sep: "delimiter",
                                                         quote_char: "quote",
                                                         encoding: "encoding",
                                                         write_headers: true,
                                                         headers: [:field1, :field2, :field3]})

      subject.open
    end


    context "when a file has no header" do
      it "should open a CSV file with no header row" do
        allow(definition).to receive(:has_header_row).and_return false

        expect(CSV).to receive(:open).with(anything, "w", {col_sep: "delimiter",
                                                           quote_char: "quote",
                                                           encoding: "encoding",
                                                           write_headers: false})

        subject.open
      end
    end
  end


  describe "#close" do
    it "should close and rename the open file" do
      subject.open

      expect(csv_file).to receive :close
      expect(FileUtils).to receive(:move).with("generated_tempname.csv", "test.csv")

      subject.close
    end
  end


  describe "#output_record" do
    it "should write the specified fields of a hash (in the specified order) as a row into the CSV file" do
      subject.open

      expect(csv_file).to receive(:<<).with ["a", "b", "c"]

      subject.write(field3: "c", field1: "a", field4: "d", field2: "b")
    end
  end

end
