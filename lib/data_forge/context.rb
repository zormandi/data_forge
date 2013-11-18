module DataForge
  class Context

    def initialize
      @file_descriptors = {}
    end



    def register_file_descriptor(name, &initialization_block)
      @file_descriptors[name] = FileDescriptor.new name
      @file_descriptors[name].instance_eval &initialization_block
    end



    def file_descriptor_by_name(name)
      @file_descriptors[name]
    end

  end
end
