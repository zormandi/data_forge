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
    it "should return an empty Hash if no fields are set" do
      file_descriptor.fields.should == {}
    end

    it "should return the fields and types that were set as a Hash" do
      file_descriptor.field :field1, String
      file_descriptor.field :field2, Fixnum

      file_descriptor.fields.should == { field1: String, field2: Fixnum }
    end
  end

end
