module DataForge
  module Transform
    module CSVWriter

      def write_csv_file(file_descriptor)
        csv_file = CSV.open "#{file_descriptor.name.to_s}.csv", "w:UTF-8", csv_write_options_for(file_descriptor)
        begin
          yield csv_file
        ensure
          csv_file.close
        end
      end



      def output_record_to_file(record, fields, file)
        file << fields.map { |field| record[field] }
      end



      private

      def csv_write_options_for(file_descriptor)
        { write_headers: true,
          headers: file_descriptor.field_names }
      end

    end
  end
end
