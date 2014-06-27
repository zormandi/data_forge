module DataForge
  module Transformation
    class Deduplication < TransformationBase

      class << self
        def from_input(source, options)
          # 1 source
          # 1 target - if missing, same as source
          # unique fields - may be single, may be array, if missing then use all fields of source
          new File.reader_for(source), File.writer_for(options[:into]), [options[:using]]
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
