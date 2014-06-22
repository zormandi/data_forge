require 'spec_helper'

module DataForge::Transform
  describe CSVWriter do

    let(:csv_writer) { Object.new.tap { |object| object.extend CSVWriter } }

    describe "#write_csv_file" do
      let(:file_descriptor1) { "FileDescriptor1" }
      let(:file_descriptor2) { "FileDescriptor2" }
      let(:file1) { double "CSV file" }
      let(:file2) { double "CSV file" }

      before do
        CSVFileWriter.stub(:new).with(file_descriptor1).and_return(file1)
        CSVFileWriter.stub(:new).with(file_descriptor2).and_return(file2)
      end

      it "should open all CSV files for writing, yield them to the specified block and close them" do
        file1.should_receive :open
        file2.should_receive :open
        file1.should_receive :close
        file2.should_receive :close

        expect do |block|
          csv_writer.write_csv_files [file_descriptor1, file_descriptor2], &block
        end.
          to yield_with_args [file1, file2]
      end

      context "when the block raises an error" do
        it "should ensure that all files are closed and propagate the error" do
          file1.stub :open
          file2.stub :open
          file1.should_receive :close
          file2.should_receive :close

          expect do
            csv_writer.write_csv_files([file_descriptor1, file_descriptor2]) { raise "test error" }
          end.
            to raise_error "test error"
        end
      end
    end

  end
end
