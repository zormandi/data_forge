require 'csv'

module DataForge
  module Transform
    class FileTransformation

      attr_accessor :context, :source_descriptor_name, :target_descriptor_name

      include DataForge::Transform::CSVWriter



      def execute(&block)
        validate_parameters
        transform @context.file_descriptor_by_name(source_descriptor_name), @context.file_descriptor_by_name(target_descriptor_name), &block
      end



      private

      def validate_parameters
        raise "Missing context for transformation" if context.nil?
        raise "Missing source descriptor for transformation" if source_descriptor_name.nil?
        raise "Missing target descriptor for transformation" if target_descriptor_name.nil?
      end



      def transform(source, target, &transformation_block)
        @source_fields = source.field_names
        @target_fields = target.field_names
        write_csv_file target do |target_file|
          @target_file = target_file
          transform_input_file source.name, &transformation_block
        end
      end



      def transform_input_file(input_file_name, &transformation_block)
        line_number = 0
        CSV.foreach "#{input_file_name.to_s}.csv", { return_headers: false } do |row|
          next if 1 == (line_number += 1)

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
