require 'spec_helper'

describe DataForge::File::Archiver::CompressionStrategy::NoCompression do

  describe "#execute" do
    context "when passed a single file name" do
      it "should return the archive file's name" do
        subject = described_class.new "archive.csv"
        allow(::File).to receive(:rename)

        expect(subject.execute ["file.csv"]).to eq "archive.csv"
      end

      it "should rename the file and use the original file's extension if the archive name doesn't contain one" do
        subject = described_class.new "archive"

        expect(::File).to receive(:rename).with "file.csv", "archive.csv"

        subject.execute ["file.csv"]
      end

      it "should rename the file and suffixing the original file's extension if the archive name contains a different one" do
        subject = described_class.new "archive.txt"

        expect(::File).to receive(:rename).with "file.csv", "archive.txt.csv"

        subject.execute ["file.csv"]
      end

      it "should rename the file to the specified name if it has the same extension as the original" do
        subject = described_class.new "archive.csv"

        expect(::File).to receive(:rename).with "file.csv", "archive.csv"

        subject.execute ["file.csv"]
      end
    end


    context "when passed multiple file names" do
      subject { described_class.new "archive" }

      it "should roll up the specified files into one tarball, delete the original files and return the archive file's name" do
        expect(DataForge::Shell).to receive(:exec!).with("tar -cf archive.tar file1.csv file2.csv")
        expect(::File).to receive(:delete).with "file1.csv"
        expect(::File).to receive(:delete).with "file2.csv"

        expect(subject.execute ["file1.csv", "file2.csv"]).to eq "archive.tar"
      end

      it "should raise an error if the tar command failed" do
        allow(DataForge::Shell).to receive(:exec!).and_raise DataForge::Shell::CommandError

        expect(::File).not_to receive(:delete).with "file1.csv"

        expect { subject.execute ["file1.csv", "file2.csv"]}.to raise_error DataForge::Shell::CommandError
      end

      it "should raise an error if deleting the files failed" do
        allow(DataForge::Shell).to receive(:exec!)
        allow(::File).to receive(:delete).with("file1.csv").and_raise "some error"

        expect { subject.execute ["file1.csv", "file2.csv"]}.to raise_error "some error"
      end
    end
  end

end
