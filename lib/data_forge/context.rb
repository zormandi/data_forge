module DataForge
  class Context

    def register_file_descriptor(name, &initialization_block)
      file_descriptor = FileDescriptor.new name
      file_descriptor.instance_eval &initialization_block
    end

  end
end
