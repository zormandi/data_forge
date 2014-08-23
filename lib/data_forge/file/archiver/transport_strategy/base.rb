module DataForge
  module File
    class Archiver
      class TransportStrategy
        class Base


          def initialize(archive_directory)
            @archive_directory = archive_directory
          end



          def execute(archive_file)
            raise "Implement this method"
          end



          protected

          attr_reader :archive_directory

        end
      end
    end
  end
end
