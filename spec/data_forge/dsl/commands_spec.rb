require 'spec_helper'

describe DataForge::DSL::Commands do

  let(:dsl_object) { Object.new.tap { |object| object.extend DataForge::DSL::Commands } }
  let(:block) { lambda {} }

  describe "#file" do
    it "should register a file descriptor" do
      expect(DataForge::File).to receive(:register_file_definition).with(:name, {}) { |&blk| expect(blk).to be block }

      dsl_object.file :name, &block
    end

    it "should pass along any options received" do
      options = {like: :other_definition}
      expect(DataForge::File).to receive(:register_file_definition).with(:name, options) { |&blk| expect(blk).to be block }

      dsl_object.file :name, options, &block
    end
  end


  describe "#transform" do
    it "should create a file transformation and execute it" do
      transformation = instance_double "DataForge::Transformation::RubyTransformation"

      allow(DataForge::Transformation::RubyTransformation).to receive(:from_input)
                                                              .with(:source, into: :target) { |&blk| expect(blk).to be block }
                                                              .and_return(transformation)
      expect(transformation).to receive(:execute)

      dsl_object.transform :source, into: :target, &block
    end
  end


  describe "#deduplicate" do
    it "should create a deduplication transformation and execute it" do
      deduplication = instance_double "DataForge::Transformation::Deduplication"
      allow(DataForge::Transformation::Deduplication).to receive(:from_input).with(:items, into: :unique_items, using: :item_id).and_return(deduplication)

      expect(deduplication).to receive(:execute)

      dsl_object.deduplicate :items, into: :unique_items, using: :item_id
    end
  end

end
