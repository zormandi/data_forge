require 'spec_helper'

describe DataForge::Transform::FileTransformationFactory do

  subject { DataForge::Transform::FileTransformationFactory }

  describe ".create" do
    it "should raise an error if called with an invalid parameter" do
      expect { subject.create "file" }.to raise_error "Invalid source-target setting for `transform` block"
    end


    context "when called with valid arguments" do

      let(:transformation) { double "transformation" }

      before do
        context = double "context"
        allow(DataForge).to receive(:context).and_return context
        allow(DataForge::Transform::FileTransformation).to receive(:new).with(context).and_return(transformation)
      end


      context "when called with a Hash" do
        it "should create a file transformation with the specified source and target(s)" do
          transformation.should_receive(:source_descriptor_name=).with(:source)
          transformation.should_receive(:target_descriptor_names=).with(:target)

          subject.create :source => :target
        end
      end

      context "when called with a Symbol" do
        it "should use the specified source as the target for the transformation" do
          transformation.should_receive(:source_descriptor_name=).with(:source)
          transformation.should_receive(:target_descriptor_names=).with(:source)

          subject.create :source
        end
      end
    end
  end

end
