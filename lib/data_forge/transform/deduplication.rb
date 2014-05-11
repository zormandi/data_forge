module DataForge
  module Transform
    class Deduplication

      include DataForge::Transform::CSVReader
      include DataForge::Transform::CSVBulkWriter



      def self.create(source, options)
        source_descriptor = DataForge.context.file_descriptor_by_name source
        target_descriptor = DataForge.context.file_descriptor_by_name options[:into]
        unique_fields = *options[:using]
        new source_descriptor, target_descriptor, unique_fields
      end



      def initialize(source_descriptor, target_descriptor, unique_fields)
        @source_descriptor, @target_descriptor = source_descriptor, target_descriptor
        @source_fields = @source_descriptor.field_names
        @unique_fields = unique_fields
      end



      def execute
        index = DeduplicationIndex.new @unique_fields
        write_csv_files [@target_descriptor] do |target_files|
          read_csv_file_by_line @source_descriptor do |row|
            record = csv_record_from_row(row, @source_fields)
            unless index.has? record
              target_files.first.output_record record
              index.add record
            end
          end
        end
      end

    end
  end
end
