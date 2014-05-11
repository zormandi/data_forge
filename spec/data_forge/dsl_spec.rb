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
      transformation = DataForge::Transform::FileTransformation.new "context"

      allow(DataForge::Transform::FileTransformationFactory).to receive(:create).with(:source).and_return(transformation)
      transformation.should_receive(:execute).with(&block)

      dsl_object.transform :source, &block
    end
  end

end
