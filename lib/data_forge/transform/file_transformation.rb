module DataForge
  module Transform
    class FileTransformation

      include DataForge::Transform::CSVReader
      include DataForge::Transform::CSVWriter



      def initialize(context)
        @context = context
      end



      def source_descriptor_name=(descriptor_name)
        @source_descriptor = @context.file_descriptor_by_name descriptor_name
        @source_fields = @source_descriptor.field_names
      end



      def target_descriptor_names=(descriptor_names)
        descriptor_names = *descriptor_names
        @target_descriptors = descriptor_names.map { |name| @context.file_descriptor_by_name name }
      end



      def execute(&transformation_block)
        validate_parameters
        transform &transformation_block
      end



      private

      def validate_parameters
        raise "Missing source file descriptor for transformation" if @source_descriptor.nil?
        raise "Missing target file descriptor for transformation" if @target_descriptors.nil? or @target_descriptors.empty?
      end



      def transform(&transformation_block)
        write_csv_files @target_descriptors do |target_files|
          @transformation_context = DataForge::Transform::TransformationContext.new @target_descriptors, target_files
          transform_source &transformation_block
        end
      end



      def transform_source(&transformation_block)
        read_records_from_csv_file @source_descriptor do |record|
          @transformation_context.instance_exec record, &transformation_block
        end
      end

    end
  end
end
