module DataForge
  module Transform
    class FileTransformationFactory

      def self.create(file_descriptor_names)
        case file_descriptor_names

          when Hash
            return DataForge::Transform::FileTransformation.new(DataForge.context).tap do |transformation|
              transformation.source_descriptor_name = file_descriptor_names.keys.first
              transformation.target_descriptor_names = file_descriptor_names.values.first
            end

          when Symbol
            return DataForge::Transform::FileTransformation.new(DataForge.context).tap do |transformation|
              transformation.source_descriptor_name = file_descriptor_names
              transformation.target_descriptor_names = file_descriptor_names
            end

          else
            raise "Invalid source-target setting for `transform` block"

        end
      end

    end
  end
end
