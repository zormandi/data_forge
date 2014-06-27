module DataForge
  module File
    module CSV
      class CSVRecordFileReader

        attr_reader :definition



        def initialize(definition)
          @definition = definition
        end



        def each_record(&block)
          ::CSV.open definition.file_name, csv_options do |csv_file|
            csv_file.shift if definition.has_header_row

            until (row = csv_file.shift).nil?
              block.call Hash[definition.field_names.zip row]
            end
          end
        end



        private

        def csv_options
          {col_sep: definition.delimiter,
           quote_char: definition.quote,
           encoding: definition.encoding,
           return_headers: false}
        end

      end
    end
  end
end
