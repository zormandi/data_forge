module RSpec
  module Helpers
    module RecordWriterHelper

      def mock_writer
        writer = instance_double "DataForge::File::RecordFileWriter"

        expect(writer).to receive(:open)
        expect(writer).to receive(:close)

        writer
      end

    end
  end
end
