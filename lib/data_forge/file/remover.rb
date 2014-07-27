module DataForge
  module File
    class Remover

      class << self

        def from_input(definition_names)
          raise "No files specified for `trash` command" if definition_names.empty?

          new definition_names.map { |name| File.definition name }
        end

      end



      def initialize(definitions)
        @definitions = definitions
      end



      def execute
        ::File.delete *@definitions.map { |definition| definition.file_name }
      end

    end
  end
end
