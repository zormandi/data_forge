module DataForge
  module File
    module CSV
      class CSVRecordFileWriter

        attr_reader :definition, :name, :fields



        def initialize(definition)
          @definition = definition
          @name = definition.name
          @fields = definition.field_names
        end



        def open
          @tempfile_name = tempfile_name
          @csv_file = ::CSV.open @tempfile_name, "w", csv_options
        end



        def close
          @csv_file.close
          FileUtils.move @tempfile_name, definition.file_name
        end



        def write(record)
          @csv_file << fields.map { |field| record[field] }
        end



        private

        def tempfile_name
          Dir::Tmpname.make_tmpname [definition.name.to_s, ".csv"], 1
        end



        def csv_options
          options = {col_sep: definition.delimiter,
                     quote_char: definition.quote,
                     encoding: definition.encoding,
                     write_headers: false}

          options.merge!({write_headers: true,
                          headers: definition.field_names}) if definition.has_header_row
          options
        end

      end
    end
  end
end
