module DataForge
  module DSL

    def file(name, &initialization_block)
      DataForge.context.register_file_descriptor name, &initialization_block
    end



    def transform(file_descriptor_names, &block)
      DataForge::Transform::FileTransformationFactory.create(file_descriptor_names).execute(&block)
    end

  end
end
