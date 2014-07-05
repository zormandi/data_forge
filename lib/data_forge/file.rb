module DataForge
  module File

    autoload :CSV, 'data_forge/file/csv'
    autoload :RecordFileDefinition, 'data_forge/file/record_file_definition'
    autoload :RecordFileReader, 'data_forge/file/record_file_reader'
    autoload :RecordFileWriter, 'data_forge/file/record_file_writer'
    autoload :Remover, 'data_forge/file/remover'


    @file_definitions = {}

    class << self

      def register_file_definition(name, options = {}, &initialization_block)
        @file_definitions[name] = if options[:like]
                                    File::RecordFileDefinition.from_existing definition(options[:like]), name, &initialization_block
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



      def definition(name)
        raise UnknownDefinitionError.new name unless @file_definitions.has_key? name

        @file_definitions[name]
      end

    end


    class UnknownDefinitionError < StandardError

      def initialize(definition_name)
        super "Unknown file definition reference '#{definition_name}'"
      end

    end

  end
end
