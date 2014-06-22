require 'spec_helper'

describe DataForge::Transform::DeduplicationIndex do

  subject { DataForge::Transform::DeduplicationIndex.new [:field1, :field2] }

  describe "#add_new?" do
    it "should return true for new records, signalling that the new record was indexed" do
      expect(subject.add_new? field1: 1, field2: 2).to be_true
    end


    it "should return false for records that were already indexed" do
      subject.add_new? field1: 1, field2: 2

      expect(subject.add_new? field1: 1, field2: 2).to be_false
    end


    it "should disregard fields not specified to be indexed" do
      subject.add_new? field1: 1, field2: 2, not_indexed: 333

      expect(subject.add_new? field1: 1, field2: 2, not_indexed: 444).to be_false
    end


    it "should raise an error if the record is missing a required field" do
      expect { subject.add_new? field1: 1 }.to raise_error, "Missing deduplication field from record: field2"
    end
  end
end
