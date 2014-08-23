require 'spec_helper'

describe DataForge::File::Archiver::TransportStrategy do

  describe ".from_destination_uri" do
    it "should return a Move strategy instance with the specified archive directory" do
      allow(DataForge::File::Archiver::TransportStrategy::Move).to receive(:new).with("archive/dir").and_return "strategy instance"

      expect(described_class.from_destination_uri "archive/dir").to eq "strategy instance"
    end
  end

end
