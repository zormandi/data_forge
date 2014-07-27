module DataForge
  module File
    class Archiver
      class Strategy

        autoload :Move, 'data_forge/file/archiver/strategy/move'



        def self.from_options(options)
          Move.from_options options
        end



        # Interface definition

        attr_reader :archive_directory

      end
    end
  end
end
