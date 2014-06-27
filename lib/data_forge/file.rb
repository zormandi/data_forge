module DataForge
  module File

    autoload :CSV, 'data_forge/file/csv'
    autoload :RecordFileDefinition, 'data_forge/file/record_file_definition'
    autoload :RecordFileReader, 'data_forge/file/record_file_reader'
    autoload :RecordFileWriter, 'data_forge/file/record_file_writer'


    @file_definitions = {}

    class << self

      def register_file_definition(name, &initialization_block)
        @file_definitions[name] = File::RecordFileDefinition.from_input name, &initialization_block
      end



      def reader_for(definition_name)
        RecordFileReader.for @file_definitions[definition_name]
      end



      def writer_for(definition_name)
        RecordFileWriter.for @file_definitions[definition_name]
      end

    end
  end
end
