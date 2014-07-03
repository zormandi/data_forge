module DataForge
  module File

    autoload :CSV, 'data_forge/file/csv'
    autoload :RecordFileDefinition, 'data_forge/file/record_file_definition'
    autoload :RecordFileReader, 'data_forge/file/record_file_reader'
    autoload :RecordFileWriter, 'data_forge/file/record_file_writer'


    @file_definitions = {}

    class << self

      attr_reader :file_definitions



      def register_file_definition(name, options, &initialization_block)
        @file_definitions[name] = if options[:like]
                                    File::RecordFileDefinition.from_existing name, definition(options[:like]), &initialization_block
                                  else
                                    File::RecordFileDefinition.from_input name, &initialization_block
                                  end
      end



      def reader_for(definition_name)
        RecordFileReader.for definition definition_name
      end



      def writer_for(definition_name)
        RecordFileWriter.for definition definition_name
      end



      private

      def definition(name)
        raise "Unknown file reference '#{name}'" unless file_definitions.has_key? name

        file_definitions[name]
      end

    end
  end
end
