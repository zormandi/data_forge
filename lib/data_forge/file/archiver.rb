require 'fileutils'

module DataForge
  module File
    class Archiver

      autoload :Strategy, 'data_forge/file/archiver/strategy'



      def self.from_input(definition_names, options)
        raise "No files specified for `archive` command" if definition_names.empty?

        file_definitions = definition_names.map { |name| File.definition name }
        strategy = Strategy.from_options options
        new file_definitions, strategy
      end



      def initialize(definitions, strategy)
        @definitions, @strategy = definitions, strategy
      end



      def execute
        ensure_archive_directory_exists
        execute_strategy
      end



      private

      def ensure_archive_directory_exists
        FileUtils.mkdir_p @strategy.archive_directory
      end



      def execute_strategy
        @strategy.execute @definitions.map { |definition| definition.file_name }
      end

    end
  end
end
