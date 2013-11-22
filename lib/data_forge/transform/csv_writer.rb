module DataForge
  module Transform
    module CSVWriter

      def write_csv_file(file_descriptor, &block)
        CSV.open "#{file_descriptor.name.to_s}.csv", "w:UTF-8", { write_headers: true,
                                                                  headers: file_descriptor.field_names }, &block
      end



      def output_record_to_file(record, fields, file)
        file << fields.map { |field| record[field] }
      end

    end
  end
end
