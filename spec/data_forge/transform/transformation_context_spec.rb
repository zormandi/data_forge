require 'spec_helper'

describe DataForge::Transform::TransformationContext do

  describe "#output" do
    it "should delegate writing the record into a file to its parent FileTransformation" do
      transformation = double("FileTransformation")
      target_file = "CSV file"
      target_fields = "field Hash"
      record = {}
      context = DataForge::Transform::TransformationContext.new transformation, target_file, target_fields

      transformation.should_receive(:output_record_to_file).with(record, target_fields, target_file)

      context.output(record)
    end
  end

end
