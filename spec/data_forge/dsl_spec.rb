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
    it "should create a DataTransformer and call it with the appropriate file descriptors" do
      transformer = double "DataTransformer"
      DataForge::Transform::FileTransformer.stub new: transformer
      source = double "Source FileDescriptor"
      DataForge.context.stub(:file_descriptor_by_name).with(:source).and_return(source)
      target = double "Target FileDescriptor"
      DataForge.context.stub(:file_descriptor_by_name).with(:target).and_return(target)

      transformer.should_receive(:transform).with(source, target, &block)

      dsl_object.transform :source => :target, &block
    end
  end

end
