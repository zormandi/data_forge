require 'spec_helper'

describe DataForge::File::Remover do

  describe ".from_input" do
    context "when no definitions are specified" do
      it "should raise an error" do
        expect { described_class.from_input [] }.to raise_error "No file definitions specified for `trash` command"
      end
    end


    context "when one of the file definition names isn't the name of a registered file definition" do
      it "should raise an error" do
        expect { described_class.from_input [:unregistered_file] }.to raise_error DataForge::File::UnknownDefinitionError
      end
    end


    it "should return a Remover object for the specified file definitions" do
      remover = instance_double described_class.name
      definition1, definition2 = stub_definitions :one, :two

      allow(described_class).to receive(:new).with([definition1, definition2]).and_return(remover)

      expect(described_class.from_input [:one, :two]).to eq remover
    end
  end


  describe "#execute" do
    it "should delete all files belonging to the specified file definitions" do
      definition1 = stub_definition :one, file_name: "first.csv"
      definition2 = stub_definition :two, file_name: "second.csv"

      expect(File).to receive(:delete).with("first.csv", "second.csv")

      described_class.new([definition1, definition2]).execute
    end
  end

end
