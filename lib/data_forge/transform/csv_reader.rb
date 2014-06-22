module DataForge
  module Transform
    module CSVReader

      def read_records_from_csv_file(file_descriptor, &block)
        CSV.open "#{file_descriptor.name.to_s}.csv", {col_sep: file_descriptor.delimiter,
                                                      quote_char: file_descriptor.quote,
                                                      encoding: file_descriptor.encoding,
                                                      return_headers: false} do |csv_file|
          csv_file.shift if file_descriptor.has_header_row
          while row = csv_file.shift
            block.call Hash[file_descriptor.field_names.zip row]
          end
        end
      end

    end
  end
end
