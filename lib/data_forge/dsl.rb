module DataForge
  module DSL

    def file(name, &initialization_block)
      DataForge.context.register_file_descriptor name, &initialization_block
    end



    def transform(file_descriptor_names, &block)
      raise "Invalid argument for `transform` block" unless file_descriptor_names.is_a? Hash

      DataForge::Transform::FileTransformation.new(DataForge.context).tap do |transformation|
        transformation.source_descriptor_name = file_descriptor_names.keys.first
        transformation.target_descriptor_names = file_descriptor_names.values.first
      end.execute(&block)
    end

  end
end
