module DataForge
  module File
    class Archiver
      class TransportStrategy
        class Move < Base

          def execute(archive_file_name)
            ensure_archive_directory_exists
            FileUtils.move archive_file_name, ::File.join(archive_directory, archive_file_name)
          end



          private

          def ensure_archive_directory_exists
            FileUtils.mkdir_p archive_directory unless Dir.exists? archive_directory
          end

        end
      end
    end
  end
end
