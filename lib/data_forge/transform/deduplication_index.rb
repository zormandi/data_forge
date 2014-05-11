module DataForge
  module Transform
    class DeduplicationIndex

      def initialize(fields)
        @fields = fields
        @fingerprints = Set.new
      end



      def has?(record)
        @fingerprints.include? fingerprint_of record
      end



      def add(record)
        @fingerprints.add fingerprint_of record
      end



      private

      def fingerprint_of(record)
        @fields.map do |field_name|
          raise StandardError, "Missing deduplication field from record: #{field_name}" unless record.has_key? field_name
          record[field_name]
        end
      end

    end
  end
end
