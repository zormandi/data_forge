module DataForge
  module File
    class RecordFileWriter

      def self.for(definition)
        CSV::CSVRecordFileWriter.new definition
      end



      # Interface definition

      attr_reader :definition, :fields, :name



      def open
      end



      def close
      end



      def write(record)
      end

    end
  end
end
