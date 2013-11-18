require 'csv'

module DataForge
  module Transform
    class DataTransformer

      def transform(source, target, &transformation_block)
        @source_fields = source.fields.keys
        CSV.open "#{target.name.to_s}.csv", "w:UTF-8", { write_headers: true, headers: target.fields.keys } do |target_file|
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

    end
  end
end
