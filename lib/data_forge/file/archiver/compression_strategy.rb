module DataForge
  module File
    class Archiver
      class CompressionStrategy

        autoload :Base, 'data_forge/file/archiver/compression_strategy/base'
        autoload :NoCompression, 'data_forge/file/archiver/compression_strategy/no_compression'


        def self.from_options(compression_method, archive_name)
          NoCompression.new archive_name
        end

      end
    end
  end
end
