require 'open3'

module DataForge
  module File
    class Archiver
      class CompressionStrategy
        class NoCompression < Base

          def execute(files_to_archive)
            if files_to_archive.count == 1
              rename_file files_to_archive.first
            else
              tar_files files_to_archive
            end
          end



          private

          def rename_file(file_name)
            archive_file_name_with_extension(::File.extname(file_name)).tap do |archive_file_name|
              ::File.rename file_name, archive_file_name
            end
          end



          def tar_files(file_names)
            archive_file_name_with_extension(".tar").tap do |archive_file_name|
              Shell.exec! "tar -cf #{archive_file_name} #{file_names.join " "}"
              file_names.each { |file_name| ::File.delete file_name }
            end
          end

        end
      end
    end
  end
end
