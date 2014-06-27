module DataForge
  module Transformation
    class RubyTransformation < TransformationBase

      class << self
        def from_input(source, options, &block)
          targets = (options.has_key? :into) ? Array(options[:into]) : [source]
          writers = targets.map { |target| File.writer_for target }

          new File.reader_for(source), writers, &block
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
