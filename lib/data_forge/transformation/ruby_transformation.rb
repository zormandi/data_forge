module DataForge
  module Transformation
    class RubyTransformation < TransformationBase

      class << self

        def from_input(source_name, options = {}, &block)
          reader = File.reader_for source_name
          writers = Array(options.fetch :into, source_name).map { |target_name| File.writer_for target_name }

          new reader, writers, &block
        end

      end



      def initialize(record_reader, record_writers, &transformation_block)
        @record_reader, @record_writers, @transformation_block = record_reader, record_writers, transformation_block
      end



      def execute
        with_writers @record_writers do |writers|
          context = RubyTransformationContext.new writers
          @record_reader.each_record do |record|
            context.instance_exec record, &@transformation_block
          end
        end
      end

    end
  end
end
