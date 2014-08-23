require 'fileutils'

module DataForge
  module File
    class Archiver

      autoload :CompressionStrategy, 'data_forge/file/archiver/compression_strategy'
      autoload :TransportStrategy, 'data_forge/file/archiver/transport_strategy'



      def self.from_input(definition_names, options)
        raise "No files specified for `archive` command" if definition_names.empty?
        files_to_archive = definition_names.map { |name| File.definition(name).file_name }

        valid_options = ValidOptions.new "archive", to: nil, as: files_to_archive.first, compress_with: :nothing
        valid_options.import options

        new files_to_archive,
            CompressionStrategy.from_options(valid_options[:compress_with], valid_options[:as]),
            TransportStrategy.from_destination_uri(valid_options[:to])
      end



      def initialize(files_to_archive, compression_strategy, transport_strategy)
        @files_to_archive, @compression_strategy, @transport_strategy = files_to_archive, compression_strategy, transport_strategy
      end



      def execute
        execute_transport_strategy_on execute_compression_strategy_on @files_to_archive
      end



      private

      def execute_compression_strategy_on(file_names)
        @compression_strategy.execute file_names
      end



      def execute_transport_strategy_on(archive_file)
        @transport_strategy.execute archive_file
      end

    end
  end
end
