module DataForge
  module File
    class Archiver
      class TransportStrategy

        autoload :Base, 'data_forge/file/archiver/transport_strategy/base'
        autoload :Move, 'data_forge/file/archiver/transport_strategy/move'



        def self.from_destination_uri(destination_uri)
          Move.new destination_uri
        end

      end
    end
  end
end
