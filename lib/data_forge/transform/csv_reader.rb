module DataForge
  module Transform
    module CSVReader

      def read_csv_file_by_line(file_descriptor, &block)
        CSV.open "#{file_descriptor.name.to_s}.csv", { col_sep: file_descriptor.delimiter,
                                                       quote_char: file_descriptor.quote,
                                                       encoding: file_descriptor.encoding,
                                                       return_headers: false
        } do |csv_file|
          csv_file.shift
          csv_file.each &block
        end
      end



      def csv_record_from_row(row, fields)
        Hash[fields.zip row]
      end

    end
  end
end
