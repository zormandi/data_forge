module DataForge
  module DSL
    module Commands

      def file(name, &initialization_block)
        File.register_file_definition name, &initialization_block
      end



      def transform(source, options = {}, &transformation_block)
        Transformation::RubyTransformation.from_input(source, options, &transformation_block).execute
      end



      def deduplicate(source, options = {})
        Transformation::Deduplication.from_input(source, options).execute
      end

    end
  end
end
