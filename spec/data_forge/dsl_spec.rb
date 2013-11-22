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
    it "should raise an error if not called with a Hash parameter" do
      expect { dsl_object.transform "file" }.to raise_error "Invalid arguments for `transform` block"
    end

    it "should create a file transformation and execute it" do
      transformation = DataForge::Transform::FileTransformation.new
      DataForge::Transform::FileTransformation.stub new: transformation

      transformation.should_receive(:execute).with(&block)

      dsl_object.transform :source => :target, &block

      transformation.context.should == DataForge.context
      transformation.source_descriptor_name.should == :source
      transformation.target_descriptor_name.should == :target
    end
  end

end
