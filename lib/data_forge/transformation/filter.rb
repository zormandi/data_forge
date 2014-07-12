module DataForge
  module Transformation
    class Filter < TransformationBase

      class << self

        def from_input(source_name, options = {}, &block)
          reader = File.reader_for source_name
          writer = File.writer_for(options.fetch :into, source_name)

          new reader, writer, &block
        end

      end



      def initialize(record_reader, record_writer, &filter_block)
        @record_reader, @record_writer, @filter_block = record_reader, record_writer, filter_block
      end



      def execute
        with_writer @record_writer do |writer|
          @record_reader.each_record do |record|
            writer.write record if @filter_block.call record
          end
        end
      end

    end
  end
end
