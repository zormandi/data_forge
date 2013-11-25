module DataForge
  module Transform
    module CSVWriter

      def write_csv_file(file_descriptor, &block)
        CSV.open "#{file_descriptor.name.to_s}.csv", "w", csv_write_options_for_descriptor(file_descriptor), &block
      end



      def output_record_to_file(record, fields, file)
        file << fields.map { |field| record[field] }
      end



      private

      def csv_write_options_for_descriptor(file_descriptor)
        options = { col_sep: file_descriptor.delimiter,
                    quote_char: file_descriptor.quote,
                    encoding: file_descriptor.encoding,
                    write_headers: false }

        options.merge!(write_headers: true, headers: file_descriptor.field_names) if file_descriptor.has_header
        options
      end

    end
  end
end
