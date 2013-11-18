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

end
