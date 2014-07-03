require 'spec_helper'

describe DataForge::File::CSV::CSVRecordFileDefinition do

  subject { described_class.new :definition_name }

  describe "#name" do
    it "should return the name of the descriptor" do
      expect(subject.name).to eq :definition_name
    end
  end


  describe "#field" do
    it "should define a field with a type" do
      subject.field :field1, String

      expect(subject.fields).to eq(field1: String)
    end

    context "when called without a type" do
      it "should define a String field" do
        subject.field :field1

        expect(subject.fields).to eq(field1: String)
      end
    end
  end


  describe "#without_field" do
    it "should remove a registered field" do
      subject.field :field1
      subject.field :field2

      subject.without_field :field1

      expect(subject.fields).to eq(field2: String)
    end
  end


  describe "#fields" do
    it "should return an empty Hash if no fields are defined" do
      expect(subject.fields).to eq({})
    end

    it "should return the fields and types (as a Hash) that are defined" do
      subject.field :field1, String
      subject.field :field2, Fixnum

      expect(subject.fields).to eq(field1: String, field2: Fixnum)
    end
  end


  describe "#field_names" do
    it "should return an empty array if no fields are defined" do
      expect(subject.field_names).to eq []
    end

    it "should return the names of the fields that are defined" do
      subject.field :field1, String
      subject.field :field2, Fixnum

      expect(subject.field_names).to eq [:field1, :field2]
    end
  end


  describe "attributes" do
    {file_name: "definition_name.csv",
     delimiter: ",",
     quote: '"',
     encoding: "UTF-8",
     has_header_row: true}
    .each do |attribute_name, default_value|

      describe "#{attribute_name}" do
        it "should return or set the attribute value" do
          subject.public_send attribute_name, "new value"

          expect(subject.public_send(attribute_name)).to eq "new value"
        end

        context "when not overridden" do
          it "should return the default value of the attribute" do
            expect(subject.send(attribute_name)).to eq default_value
          end
        end
      end

    end
  end


  describe "#separator" do
    it "should be an alias for #delimiter" do
      expect(subject.separator).to eq ","

      subject.delimiter ";"
      expect(subject.separator).to eq ";"

      subject.separator "|"
      expect(subject.delimiter).to eq "|"
    end
  end


  describe "#copy" do
    it "should copy the non-identifying attributes of the specified definition" do
      definition = described_class.new :def1
      definition.file_name "first.csv"
      definition.delimiter ";"
      definition.quote "'"
      definition.encoding "Latin2"
      definition.field :f1
      definition.field :f2

      subject.copy definition

      expect(subject.name).to eq :definition_name
      expect(subject.file_name).to eq "definition_name.csv"
      expect(subject.delimiter).to eq ";"
      expect(subject.quote).to eq "'"
      expect(subject.encoding).to eq "Latin2"
      expect(subject.field_names).to eq [:f1, :f2]
    end
  end

end
