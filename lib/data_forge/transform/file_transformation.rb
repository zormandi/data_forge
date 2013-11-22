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



      def target_descriptor_name=(descriptor_name)
        @target_descriptor = @context.file_descriptor_by_name descriptor_name
        @target_fields = @target_descriptor.field_names
      end



      def execute(&transformation_block)
        validate_parameters
        transform &transformation_block
      end



      private

      def validate_parameters
        raise "Missing source descriptor for transformation" if @source_descriptor.nil?
        raise "Missing target descriptor for transformation" if @target_descriptor.nil?
      end



      def transform(&transformation_block)
        write_csv_file @target_descriptor do |target_file|
          @target_file = target_file
          transform_source &transformation_block
        end
      end



      def transform_source(&transformation_block)
        read_csv_file_by_line @source_descriptor do |row|
          @record = Hash[@source_fields.zip row]
          self.instance_exec @record, &transformation_block
        end
      end



      def output(record)
        output_record_to_file record, @target_fields, @target_file
      end

    end
  end
end
