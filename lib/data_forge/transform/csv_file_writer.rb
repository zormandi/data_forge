module DataForge
  module Transform
    class CSVFileWriter

      def initialize(file_descriptor)
        @file_descriptor = file_descriptor
        @fields = file_descriptor.field_names
      end



      def open
        raise "File is already open" unless @csv.nil?
        @csv = CSV.open tempfile_name, "w", csv_write_options
      end



      def close
        raise "File isn't open" if @csv.nil?
        @csv.close
        rename_file_to_final_name
      end



      def output_record(record)
        raise "File isn't open" if @csv.nil?
        @csv << @fields.map { |field| record[field] }
      end



      private

      def tempfile_name
        @tempfile_name ||= Dir::Tmpname.make_tmpname [@file_descriptor.name.to_s, ".csv"], 1
      end



      def csv_write_options
        options = { col_sep: @file_descriptor.delimiter,
                    quote_char: @file_descriptor.quote,
                    encoding: @file_descriptor.encoding,
                    write_headers: false }

        options.merge!(write_headers: true, headers: @file_descriptor.field_names) if @file_descriptor.has_header
        options
      end



      def rename_file_to_final_name
        FileUtils.mv tempfile_name, file_name
      end



      def file_name
        "#{@file_descriptor.name.to_s}.csv"
      end

    end
  end
end
