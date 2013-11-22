module DataForge
  module Transform
    class TransformationContext

      def initialize(transformation, target_file, target_fields)
        @transformation, @target_file, @target_fields = transformation, target_file, target_fields
      end



      def output(record)
        @transformation.output_record_to_file record, @target_fields, @target_file
      end

    end
  end
end
