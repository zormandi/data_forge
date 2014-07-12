module DataForge
  module DSL
    module Commands

      def file(name, options = {}, &initialization_block)
        File.register_file_definition name, options, &initialization_block
      end



      def transform(source, options = {}, &transformation_block)
        Transformation::RubyTransformation.from_input(source, options, &transformation_block).execute
      end



      def filter(source, options = {}, &filter_block)
        Transformation::Filter.from_input(source, options, &filter_block).execute
      end



      def deduplicate(source, options = {})
        Transformation::Deduplication.from_input(source, options).execute
      end



      def trash(*names)
        File::Remover.from_input(names).execute
      end

    end
  end
end
