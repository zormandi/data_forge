module DataForge
  module DSL

    def file(name, &initialization_block)
      DataForge.context.register_file_descriptor name, &initialization_block
    end



    def transform(file_descriptor_names, &block)
      source = DataForge.context.file_descriptor_by_name file_descriptor_names.keys.first
      target = DataForge.context.file_descriptor_by_name file_descriptor_names.values.first

      DataForge::Transform::FileTransformer.new.transform source, target, &block
    end

  end
end
