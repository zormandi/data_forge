require 'spec_helper'

describe DataForge::Transform::TransformationContext do

  let(:transformation) { double("FileTransformation") }
  let(:descriptor1) { double "FileDescriptor", name: :descriptor1, field_names: [:field11, :field12] }
  let(:descriptor2) { double "FileDescriptor", name: :descriptor2, field_names: [:field21, :field22] }
  let(:file1) { "CSV file 1" }
  let(:file2) { "CSV file 2" }

  describe "#output" do
    context "when the context has only 1 file descriptor" do
      let(:context) { DataForge::Transform::TransformationContext.new transformation, [descriptor1], [file1] }

      it "should accept a record as its single argument" do
        transformation.should_receive(:output_record_to_file).with("record", [:field11, :field12], file1)

        context.output "record"
      end

      it "should accept a Hash specifying the target as its second argument" do
        transformation.should_receive(:output_record_to_file).with("record", [:field11, :field12], file1)

        context.output "record", to: :descriptor1
      end

      it "should raise an error if an unknown file descriptor name is specified as target" do
        expect { context.output "record", to: :unknown_descriptor }.
          to raise_error "Unknown target file descriptor 'unknown_descriptor' for `output` command"
      end
    end


    context "when the context has only multiple file descriptors" do
      let(:context) { DataForge::Transform::TransformationContext.new transformation, [descriptor1, descriptor2], [file1, file2] }

      it "should raise an error if a record is given as its single argument" do
        expect { context.output "record" }.to raise_error "Missing target file descriptor for `output` command in multiple file transformation"
      end

      it "should accept a Hash specifying a single target as its second argument" do
        transformation.should_receive(:output_record_to_file).with("record", [:field11, :field12], file1)

        context.output "record", to: :descriptor1
      end

      it "should accept a Hash specifying an array of targets as its second argument" do
        transformation.should_receive(:output_record_to_file).with("record", [:field11, :field12], file1)
        transformation.should_receive(:output_record_to_file).with("record", [:field21, :field22], file2)

        context.output "record", to: [:descriptor1, :descriptor2]
      end
    end
  end

end
