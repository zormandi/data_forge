require 'spec_helper'

describe DataForge::File::Archiver::CompressionStrategy do

  describe ".from_options" do
    it "should return a NoCompression strategy instance with the specified archive name" do
      allow(DataForge::File::Archiver::CompressionStrategy::NoCompression).to receive(:new).with("archive name").and_return "strategy instance"

      expect(described_class.from_options :nothing, "archive name").to eq "strategy instance"
    end
  end

end
