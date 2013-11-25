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

    context "when called without a type" do
      it "should define a String field" do
        file_descriptor.field :field1

        file_descriptor.fields.should == { field1: String }
      end
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

    it "should return the names of the fields that are defined" do
      file_descriptor.field :field1, String
      file_descriptor.field :field2, Fixnum

      file_descriptor.field_names.should == [:field1, :field2]
    end
  end


  describe "attributes" do
    { delimiter: ",",
      quote: '"',
      encoding: "UTF-8",
      has_header: true }.each do |attribute_name, default_value|

      describe "#{attribute_name}" do
        it "should return or set the attribute value" do
          file_descriptor.send attribute_name, "new value"

          file_descriptor.send(attribute_name).should == "new value"
        end

        context "when not overridden" do
          it "should return the default value of the attribute" do
            file_descriptor.send(attribute_name).should == default_value
          end
        end
      end

    end
  end


  describe "#separator" do
    it "should be an alias for #delimiter" do
      file_descriptor.separator.should == ","

      file_descriptor.delimiter ";"
      file_descriptor.separator.should == ";"

      file_descriptor.separator "|"
      file_descriptor.delimiter.should == "|"
    end
  end

end
