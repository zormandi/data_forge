module DataForge
  module File
    module RecordFileDefinition

      class << self

        def from_input(name, &initializer_block)
          create name, &initializer_block
        end



        def from_existing(definition_to_copy, name, &customization_block)
          create name, definition_to_copy, &customization_block
        end



        private

        def create(name, definition_to_copy = nil, &initializer_block)
          CSV::CSVRecordFileDefinition.new(name).tap do |definition|
            definition.copy definition_to_copy if definition_to_copy
            definition.instance_eval &initializer_block if initializer_block
          end
        end

      end


      public

      # Interface definition

      attr_reader :name, :file_name, :fields



      def copy(definition)
      end

    end
  end
end
