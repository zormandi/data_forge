module DataForge
  module File
    module RecordFileDefinition

      def self.from_input(name, &initialization_block)
        from_copy nil, name, &initialization_block
      end



      def self.from_copy(source_definition, name, &initialization_block)
        CSV::CSVRecordFileDefinition.new(name).tap do |definition|
          definition.copy source_definition if source_definition
          definition.instance_eval &initialization_block if initialization_block
        end
      end



      # Interface definition

      attr_reader :name, :fields



      def copy(definition)
      end

    end
  end
end
