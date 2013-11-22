require 'spec_helper'

describe DataForge::Context do

  let(:context) { DataForge::Context.new }

  describe "#register_file_descriptor" do
    it "should register a new file descriptor and initialize it through the block passed" do
      block = lambda {}
      file = double "FileDescriptor"
      DataForge::FileDescriptor.stub(:new).with(:name).and_return(file)

      file.should_receive(:instance_eval).with(&block)

      context.register_file_descriptor :name, &block
    end
  end


  describe "#file_descriptor_by_name" do
    it "should raise an error if a file descriptor with the specified name wasn't registered yet" do
      expect { context.file_descriptor_by_name :name }.to raise_error "Unknown file 'name'"
    end

    it "should return the file descriptor whose name was specified" do
      context.register_file_descriptor(:name) { field :test, String }

      context.file_descriptor_by_name(:name).should be_a DataForge::FileDescriptor
      context.file_descriptor_by_name(:name).fields.should == { test: String }
    end
  end

end
