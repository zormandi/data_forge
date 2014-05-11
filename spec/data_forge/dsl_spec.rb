require 'spec_helper'

describe DataForge::DSL do

  let(:dsl_object) { Object.new.tap { |object| object.extend DataForge::DSL } }
  let(:block) { lambda {} }

  describe "#file" do
    it "should register a file descriptor" do
      DataForge.context.should_receive(:register_file_descriptor).with(:name, &block)

      dsl_object.file :name, &block
    end
  end


  describe "#transform" do
    it "should create a file transformation and execute it" do
      transformation = double "file transformation"

      allow(DataForge::Transform::FileTransformationFactory).to receive(:create).with(:source).and_return(transformation)
      expect(transformation).to receive(:execute).with(&block)

      dsl_object.transform :source, &block
    end
  end


  describe "#deduplicate" do
    it "should create a deduplication transformation and execute it" do
      deduplication = double "deduplication"
      allow(DataForge::Transform::Deduplication).to receive(:create).with(:items, into: :unique_items, using: :item_id).and_return(deduplication)

      expect(deduplication).to receive(:execute)

      dsl_object.deduplicate :items, into: :unique_items, using: :item_id
    end
  end

end
