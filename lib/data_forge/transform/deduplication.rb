module DataForge
  module Transform
    class Deduplication

      include DataForge::Transform::CSVReader
      include DataForge::Transform::CSVWriter



      def self.create(source, options)
        source_descriptor = DataForge.context.file_descriptor_by_name source
        target_descriptor = DataForge.context.file_descriptor_by_name options[:into]
        unique_fields = *options[:using]

        new source_descriptor, target_descriptor, unique_fields
      end



      def initialize(source_descriptor, target_descriptor, unique_fields)
        @source_descriptor, @target_descriptor, @unique_fields = source_descriptor, target_descriptor, unique_fields
      end



      def execute
        index = DeduplicationIndex.new @unique_fields

        write_csv_file @target_descriptor do |target_file|
          read_records_from_csv_file @source_descriptor do |record|
            target_file.output_record record if index.add_new? record
          end
        end
      end

    end
  end
end
