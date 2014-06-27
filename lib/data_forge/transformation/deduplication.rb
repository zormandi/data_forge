module DataForge
  module Transformation
    class Deduplication < TransformationBase

      class << self
        def from_input(source, options = {})
          reader = File.reader_for source
          writer = (options.has_key? :into) ? File.writer_for(options[:into]) : File.writer_for(source)
          unique_fields = (options.has_key? :using) ? Array(options[:using]) : reader.fields

          new reader, writer, unique_fields
        end
      end



      def initialize(reader, writer, unique_fields)
        @reader, @writer, @unique_fields = reader, writer, unique_fields
        @fingerprints = Set.new
      end



      def execute
        with_writer @writer do |writer|
          @reader.each_record do |record|
            fingerprint = @unique_fields.map { |field_name| record[field_name] }
            unless @fingerprints.include? fingerprint
              @fingerprints.add fingerprint
              writer.write record
            end
          end
        end
      end

    end
  end
end
