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
    it "should raise an error if not called with an invalid parameter" do
      expect { dsl_object.transform "file" }.to raise_error "Invalid source-target setting for `transform` block"
    end


    context "when called with valid arguments" do

      let(:transformation) { DataForge::Transform::FileTransformation.new "context" }
      before do
          DataForge::Transform::FileTransformation.stub new: transformation
      end

      context "when called with a Hash" do
        it "should create a file transformation with the specified source and target(s) and execute it" do
          transformation.should_receive(:source_descriptor_name=).with(:source)
          transformation.should_receive(:target_descriptor_names=).with(:target)
          transformation.should_receive(:execute).with(&block)

          dsl_object.transform :source => :target, &block
        end
      end

      context "when called with a Symbol" do
        it "should use the specified source as the target for the transformation" do
          transformation.should_receive(:source_descriptor_name=).with(:source)
          transformation.should_receive(:target_descriptor_names=).with(:source)
          transformation.should_receive(:execute).with(&block)

          dsl_object.transform :source, &block
        end
      end
    end
  end

end
