module RSpec
  module Helpers
    module RecordReaderHelper

      def stub_reader_with_records(records)
        reader = instance_double "DataForge::File::RecordFileReader"

        match_records = receive(:each_record)
        records.each { |record| match_records.and_yield record }
        allow(reader).to match_records

        reader
      end

    end
  end
end
