module RSpec
  module Helpers
    module FileDefinitionHelper

      def stub_definition(name, messages = {})
        stub_definitions(name).first.tap do |definition|
          allow(definition).to receive_messages messages
        end
      end



      def stub_definitions(*names)
        names.map do |definiton_name|
          definition = instance_double "DataForge::File::RecordFileDefinition"
          allow(DataForge::File).to receive(:definition).with(definiton_name).and_return definition
          definition
        end
      end

    end
  end
end
