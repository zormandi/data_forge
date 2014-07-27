require 'spec_helper'

describe DataForge::DSL::Commands do

  subject { Object.new.tap { |object| object.extend DataForge::DSL::Commands } }
  let(:block) { lambda {} }

  describe "#file" do
    it "should register a file descriptor" do
      expect(DataForge::File).to receive(:register_file_definition).with(:name, {}) { |&blk| expect(blk).to be block }

      subject.file :name, &block
    end

    it "should pass along any options received" do
      options = {like: :other_definition}
      expect(DataForge::File).to receive(:register_file_definition).with(:name, options) { |&blk| expect(blk).to be block }

      subject.file :name, options, &block
    end
  end


  describe "#transform" do
    it "should create a file transformation and execute it" do
      transformation = instance_double "DataForge::Transformation::RubyTransformation"

      allow(DataForge::Transformation::RubyTransformation).to receive(:from_input)
                                                              .with(:source, into: :target) { |&blk| expect(blk).to be block }
                                                              .and_return(transformation)
      expect(transformation).to receive(:execute)

      subject.transform :source, into: :target, &block
    end
  end


  describe "#filter" do
    it "should create a filter transformation and execute it" do
      transformation = instance_double "DataForge::Transformation::Filter"

      allow(DataForge::Transformation::Filter).to receive(:from_input)
                                                  .with(:source, into: :target) { |&blk| expect(blk).to be block }
                                                  .and_return(transformation)
      expect(transformation).to receive(:execute)

      subject.filter :source, into: :target, &block
    end
  end


  describe "#deduplicate" do
    it "should create a deduplication transformation and execute it" do
      deduplication = instance_double "DataForge::Transformation::Deduplication"
      allow(DataForge::Transformation::Deduplication).to receive(:from_input).with(:items, into: :unique_items, using: :item_id).and_return(deduplication)

      expect(deduplication).to receive(:execute)

      subject.deduplicate :items, into: :unique_items, using: :item_id
    end
  end


  describe "#archive" do
    let(:archiver) { instance_double "DataForge::File::Archiver" }

    context "with one file" do
      it "should create a file archiver with all options and the specified file definition as an array" do
        allow(DataForge::File::Archiver).to receive(:from_input).with([:file1], {to: "some/dir"}).and_return(archiver)

        expect(archiver).to receive(:execute)

        subject.archive :file1, to: "some/dir"
      end
    end

    context "with multiple files" do
      it "should create a file remover with all specified file definitions" do
        allow(DataForge::File::Archiver).to receive(:from_input).with([:file1, :file2], {to: "some/dir"}).and_return(archiver)

        expect(archiver).to receive(:execute)

        subject.archive :file1, :file2, to: "some/dir"
      end
    end
  end


  describe "#trash" do
    let(:remover) { instance_double "DataForge::File::Remover" }

    context "with one file" do
      it "should create a file remover with the specified file definition as an array" do
        allow(DataForge::File::Remover).to receive(:from_input).with([:file1]).and_return(remover)

        expect(remover).to receive(:execute)

        subject.trash :file1
      end
    end

    context "with multiple files" do
      it "should create a file remover with all specified file definitions" do
        remover = instance_double "DataForge::File::Remover"
        allow(DataForge::File::Remover).to receive(:from_input).with([:file1, :file2]).and_return(remover)

        expect(remover).to receive(:execute)

        subject.trash :file1, :file2
      end
    end
  end

end
