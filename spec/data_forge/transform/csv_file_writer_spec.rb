require 'spec_helper'

describe DataForge::Transform::CSVFileWriter do

  let(:csv) { double "CSV" }
  let(:file_descriptor) do
    DataForge::FileDescriptor.new(:fd_name).tap do |file_descriptor|
      file_descriptor.delimiter "delimiter"
      file_descriptor.quote "quote"
      file_descriptor.encoding "encoding"
      file_descriptor.has_header_row true
      file_descriptor.field :field1
      file_descriptor.field :field2
      file_descriptor.field :field3
    end
  end
  let(:writer) { DataForge::Transform::CSVFileWriter.new file_descriptor }

  before do
    Dir::Tmpname.stub(:make_tmpname).with(["fd_name", ".csv"], 1).and_return("temp.csv")
    CSV.stub :open => csv
  end


  describe "#open" do
    it "should open a CSV file for writing with a temporary filename" do
      CSV.should_receive(:open).with("temp.csv", "w", anything)

      writer.open
    end

    it "should raise an error if the file is already open" do
      writer.open

      expect { writer.open }.to raise_error "File is already open"
    end

    it "should use the file descriptor's settings as CSV options" do
      CSV.should_receive(:open).with(anything, "w", { col_sep: "delimiter",
                                                      quote_char: "quote",
                                                      encoding: "encoding",
                                                      write_headers: true,
                                                      headers: [:field1, :field2, :field3] })

      writer.open
    end

    context "when a file has no header" do
      it "should open a CSV file with no header row" do
        file_descriptor.has_header_row false

        CSV.should_receive(:open).with(anything, "w", { col_sep: "delimiter",
                                                        quote_char: "quote",
                                                        encoding: "encoding",
                                                        write_headers: false })

        writer.open
      end
    end
  end


  describe "#close" do
    it "should close and rename the open file" do
      writer.open

      csv.should_receive :close
      FileUtils.should_receive(:mv).with("temp.csv", "fd_name.csv")

      writer.close
    end

    it "should raise an error if the file isn't open" do
      expect { writer.close }.to raise_error "File isn't open"
    end
  end


  describe "#output_record" do
    it "should output specific fields of a record (in order) as a row into a CSV file" do
      writer.open

      csv.should_receive(:<<).with([4, 1, 3])

      writer.output_record({ :field2 => 1, :field4 => 2, :field3 => 3, :field1 => 4, :field5 => 5 })
    end

    it "should raise an error if the file isn't open" do
      expect { writer.output_record({}) }.to raise_error "File isn't open"
    end
  end

end
