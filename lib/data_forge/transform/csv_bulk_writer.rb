module DataForge
  module Transform
    module CSVBulkWriter

      def write_csv_files(file_descriptors, &block)
        csv_files = open_files_for_writing file_descriptors

        begin
          yield csv_files
        ensure
          csv_files.each { |file| file.close }
        end
      end



      private

      def open_files_for_writing(file_descriptors)
        file_descriptors.map do |file_descriptor|
          CSVFileWriter.new(file_descriptor).tap { |file| file.open }
        end
      end

    end
  end
end
