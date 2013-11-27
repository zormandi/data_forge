require 'spec_helper'

describe DataForge::Transform::FileTransformation do

  let(:context) { double "Context" }
  let(:transformation) { DataForge::Transform::FileTransformation.new(context) }

  describe "#source_descriptor_name=" do
    it "should look up the descriptor registered by that name" do
      context.should_receive(:file_descriptor_by_name).with(:source).and_return(double("Descriptor").as_null_object)

      transformation.source_descriptor_name = :source
    end
  end


  describe "#target_descriptor_names=" do
    context "when called with a single descriptor name" do
      it "should look up the descriptor registered by that name" do
        context.should_receive(:file_descriptor_by_name).with(:target)

        transformation.target_descriptor_names = :target
      end
    end

    context "when called with an array of descriptor names" do
      it "should look up the descriptors registered by the specified names" do
        context.should_receive(:file_descriptor_by_name).with(:target1)
        context.should_receive(:file_descriptor_by_name).with(:target2)

        transformation.target_descriptor_names = [:target1, :target2]
      end
    end
  end


  describe "#execute" do
    context "when validating its parameters" do
      it "should raise an error if no source descriptors are set" do
        context.stub(:file_descriptor_by_name).with(:target)
        transformation.target_descriptor_names = :target

        expect { transformation.execute {} }.to raise_error "Missing source file descriptor for transformation"
      end

      it "should raise an error if no target descriptors are set" do
        context.stub(:file_descriptor_by_name).with(:source).and_return(double("Descriptor").as_null_object)
        transformation.source_descriptor_name = :source

        expect { transformation.execute {} }.to raise_error "Missing target file descriptor for transformation"
      end

      it "should raise an error if target descriptors are set to empty array" do
        context.stub(:file_descriptor_by_name).with(:source).and_return(double("Descriptor").as_null_object)
        transformation.source_descriptor_name = :source
        transformation.target_descriptor_names = []

        expect { transformation.execute {} }.to raise_error "Missing target file descriptor for transformation"
      end
    end
  end

end
