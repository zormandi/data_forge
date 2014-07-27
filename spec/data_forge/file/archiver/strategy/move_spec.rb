require 'spec_helper'

describe DataForge::File::Archiver::Strategy::Move do

  describe ".from_options" do
    it "should return a Move strategy instance with the specified parameters" do
      allow(described_class).to receive(:new).with("to", "prefix", "suffix").and_return "strategy instance"

      expect(described_class.from_options to: "to", with_prefix: "prefix", with_suffix: "suffix").to eq "strategy instance"
    end

    it "should raise an error if no :to option was specified" do
      expect { described_class.from_options({}) }.to raise_error "Missing :to directive for `archive` command"
    end

    it "should use empty string as the default prefix and suffix" do
      allow(described_class).to receive(:new).with("to", "", "").and_return "strategy instance"

      expect(described_class.from_options to: "to").to eq "strategy instance"
    end

    it "should raise an error if an unknown option was specified" do
      expect { described_class.from_options foo: true }.to raise_error "Unknown directive :foo specified for `archive` command"
    end
  end


  describe "#execute" do
    subject { described_class.new "arc/hive", 2014, "_done" }

    it "should move the specified files to the archive directory using the preset prefix and suffix" do
      expect(FileUtils).to receive(:move).with("file1.csv", "arc/hive/2014file1_done.csv")
      expect(FileUtils).to receive(:move).with("file2.csv", "arc/hive/2014file2_done.csv")

      subject.execute ["file1.csv", "file2.csv"]
    end
  end

end
