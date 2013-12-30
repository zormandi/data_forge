module DataForge
  module Transform
    class TransformationContext

      def initialize(target_descriptors, target_files)
        descriptor_names = target_descriptors.map { |descriptor| descriptor.name }
        @target_files = Hash[descriptor_names.zip target_files]
      end



      def output(record, options = {})
        target_descriptor_names_for(options).each do |descriptor_name|
          @target_files[descriptor_name].output_record record
        end
      end



      private

      def target_descriptor_names_for(options)
        return validated_descriptor_names_in(*options[:to]) if options.has_key? :to
        default_descriptor_name_in_array
      end



      def validated_descriptor_names_in(*descriptor_names)
        descriptor_names.each do |descriptor_name|
          raise "Unknown target file descriptor '#{descriptor_name}' for `output` command" unless @target_files.has_key? descriptor_name
        end
      end



      def default_descriptor_name_in_array
        raise "Missing target file descriptor for `output` command in multiple file transformation" if @target_files.count > 1
        [@target_files.keys.first]
      end

    end
  end
end
