require 'csv'

module DataForge
  module Transform
    class FileTransformer

      def initialize(context)
        @context = context
      end



      def transform_between_descriptors(source_descriptor_name, target_descriptor_name, &transformation_block)
        source = @context.file_descriptor_by_name source_descriptor_name
        target = @context.file_descriptor_by_name target_descriptor_name
        transform source, target, &transformation_block
      end



      def transform(source, target, &transformation_block)
        @source_fields = source.field_names
        @target_fields = target.field_names
        CSV.open "#{target.name.to_s}.csv", "w:UTF-8", { write_headers: true, headers: @target_fields } do |target_file|
          @target_file = target_file
          transform_input_file source.name, &transformation_block
        end
      end



      private

      def transform_input_file(input_file_name, &transformation_block)
        line_number = 0
        CSV.foreach "#{input_file_name.to_s}.csv", { return_headers: false } do |row|
          next if 1 == (line_number += 1)

          @record = Hash[@source_fields.zip row]
          self.instance_exec @record, &transformation_block
        end
      end



      def output(record)
        @target_file << record.
          keep_if { |key| @target_fields.include? key }.
          sort_by { |field, _| @target_fields.index(field) }.
          map { |item| item[1] }
      end


    end
  end
end
