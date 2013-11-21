module DataForge
  module DSL

    ERROR_TRANSFORM_INVALID_PARAMS = "Invalid arguments for `transform`.\n" \
                                     "A `transform` block expects two file descriptors as arguments, e.g. transform :source => :target"



    def file(name, &initialization_block)
      DataForge.context.register_file_descriptor name, &initialization_block
    end



    def transform(file_descriptor_names, &block)
      raise ArgumentError, ERROR_TRANSFORM_INVALID_PARAMS unless file_descriptor_names.is_a? Hash
      raise ArgumentError, ERROR_TRANSFORM_INVALID_PARAMS if file_descriptor_names.empty?

      DataForge::Transform::FileTransformer.new(DataForge.context).
        transform_between_descriptors file_descriptor_names.keys.first, file_descriptor_names.values.first, &block
    end

  end
end
