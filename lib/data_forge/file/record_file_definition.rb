module DataForge
  module File
    module RecordFileDefinition

      def self.from_input(name, &initializer_block)
        from_existing name, &initializer_block
      end



      def self.from_existing(name, definition_to_copy = nil, &customization_block)
        CSV::CSVRecordFileDefinition.new(name).tap do |definition|
          definition.copy definition_to_copy if definition_to_copy
          definition.instance_eval &customization_block if customization_block
        end
      end



      # Interface definition

      attr_reader :name, :fields



      def copy(definition)
      end

    end
  end
end
