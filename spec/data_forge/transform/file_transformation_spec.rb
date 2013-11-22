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


  describe "#target_descriptor_name=" do
    it "should look up the descriptor registered by that name" do
      context.should_receive(:file_descriptor_by_name).with(:target).and_return(double("Descriptor").as_null_object)
      transformation.target_descriptor_name = :target
    end
  end


  describe "#execute" do
    context "when validating its parameters" do
      it "should raise an error if :source_descriptor_name isn't set" do
        context.stub(:file_descriptor_by_name).with(:target).and_return(double("Descriptor").as_null_object)
        transformation.target_descriptor_name = :target

        expect { transformation.execute {} }.to raise_error "Missing source descriptor for transformation"
      end

      it "should raise an error if :target_descriptor_name isn't set" do
        context.stub(:file_descriptor_by_name).with(:source).and_return(double("Descriptor").as_null_object)
        transformation.source_descriptor_name = :source

        expect { transformation.execute {} }.to raise_error "Missing target descriptor for transformation"
      end
    end
  end

end
