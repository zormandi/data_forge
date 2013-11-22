require 'spec_helper'

describe DataForge::Transform::FileTransformation do

  let(:transformation) { DataForge::Transform::FileTransformation.new }

  describe "#execute" do
    context "when validating its parameters" do
      before(:each) do
        transformation.context = "context"
        transformation.source_descriptor_name = "source"
        transformation.target_descriptor_name = "target"
      end

      it "should raise an error if :context isn't set" do
        transformation.context = nil
        expect { transformation.execute {} }.to raise_error "Missing context for transformation"
      end

      it "should raise an error if :source_descriptor_name isn't set" do
        transformation.source_descriptor_name = nil
        expect { transformation.execute {} }.to raise_error "Missing source descriptor for transformation"
      end

      it "should raise an error if :target_descriptor_name isn't set" do
        transformation.target_descriptor_name = nil
        expect { transformation.execute {} }.to raise_error "Missing target descriptor for transformation"
      end
    end
  end

end
