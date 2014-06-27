module DataForge
  module DSL

    def file(name, &initialization_block)
      File.register_file_definition name, &initialization_block
    end



    def transform(source, options = {}, &block)
      Transformation::RubyTransformation.from_input(source, options, &block).execute
    end



    def deduplicate(source, options = {})
      Transformation::Deduplication.from_input(source, options).execute
    end

  end
end
