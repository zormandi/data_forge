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
    it "should raise an error if not called with a non-empty Hash parameter" do
      expect { dsl_object.transform "file" }.to raise_error ArgumentError, DataForge::DSL::ERROR_TRANSFORM_INVALID_PARAMS
      expect { dsl_object.transform({}) }.to raise_error ArgumentError, DataForge::DSL::ERROR_TRANSFORM_INVALID_PARAMS
    end

    it "should create a file transformer and call it with the appropriate file descriptor names" do
      transformer = double "DataTransformer"
      DataForge::Transform::FileTransformer.stub(:new).with(DataForge.context).and_return(transformer)

      transformer.should_receive(:transform_between_descriptors).with(:source, :target, &block)

      dsl_object.transform :source => :target, &block
    end
  end

end
