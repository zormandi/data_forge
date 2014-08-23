module DataForge
  module File
    class Archiver
      class CompressionStrategy
        class Base

          def initialize(archive_name)
            @archive_name = archive_name
          end



          def execute(files_to_archive)
            raise "Implement this method"
          end



          protected

          attr_reader :archive_name



          def archive_file_name_with_extension(extension)
            if ::File.extname(archive_name) == extension
              archive_name
            else
              archive_name + extension
            end
          end

        end
      end
    end
  end
end
