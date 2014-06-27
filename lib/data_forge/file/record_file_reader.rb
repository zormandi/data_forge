module DataForge
  module File
    class RecordFileReader

      def self.for(definition)
        CSV::CSVRecordFileReader.new definition
      end



      # Interface definition

      def each_record(&block)
      end

    end
  end
end
