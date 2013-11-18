module DataForge
  module DSL

    def file(name, &initialization_block)
      DataForge.context.register_file_descriptor name, &initialization_block
    end

  end
end
