module DataForge
  module File
    module RecordFileDefinition

      def self.from_input(name, &initialization_block)
        CSV::CSVRecordFileDefinition.new(name).tap { |definition| definition.instance_eval &initialization_block }
      end

    end
  end
end
