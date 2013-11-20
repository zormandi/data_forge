require 'spec_helper'

describe DataForge::FileDescriptor do

  let(:file_descriptor) { DataForge::FileDescriptor.new :name }

  describe "#name" do
    it "should return the name of the descriptor" do
      file_descriptor.name.should == :name
    end
  end


  describe "#field" do
    it "should define a field with a type" do
      file_descriptor.field :field1, String

      file_descriptor.fields.should == { field1: String }
    end
  end


  describe "#fields" do
    it "should return an empty Hash if no fields are defined" do
      file_descriptor.fields.should == {}
    end

    it "should return the fields and types (as a Hash) that are defined" do
      file_descriptor.field :field1, String
      file_descriptor.field :field2, Fixnum

      file_descriptor.fields.should == { field1: String, field2: Fixnum }
    end
  end

  describe "#field_names" do
    it "should return an empty array if no fields are defined" do
      file_descriptor.field_names.should == []
    end

    it "should return the names of the fields that were defined" do
      file_descriptor.field :field1, String
      file_descriptor.field :field2, Fixnum

      file_descriptor.field_names.should == [:field1, :field2]
    end
  end
end
