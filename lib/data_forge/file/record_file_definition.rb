module DataForge
  module File
    module RecordFileDefinition

      def self.from_input(name, &initialization_block)
        CSV::CSVRecordFileDefinition.new(name).tap { |definition| definition.instance_eval &initialization_block }
      end



      # Interface definition

      attr_reader :name, :fields

    end
  end
end
