require 'spec_helper'

describe DataForge::File::Archiver::TransportStrategy::Move do
  subject { described_class.new "arc/hive" }

  describe "#execute" do
    it "should create the archive directory if it doesn't exist" do
      allow(FileUtils).to receive(:move)
      allow(Dir).to receive(:exists?).with("arc/hive").and_return false

      expect(FileUtils).to receive(:mkdir_p).with("arc/hive")

      subject.execute "archive.tar"
    end

    it "should ensure the archive directory exists" do
      allow(FileUtils).to receive(:move)
      allow(Dir).to receive(:exists?).with("arc/hive").and_return true

      expect(FileUtils).not_to receive(:mkdir_p)

      subject.execute "archive.tar"
    end

    it "should move the specified file to the archive directory" do
      allow(Dir).to receive(:exists?).with("arc/hive").and_return true

      expect(FileUtils).to receive(:move).with("archive.tar", "arc/hive/archive.tar")

      subject.execute "archive.tar"
    end
  end

end
