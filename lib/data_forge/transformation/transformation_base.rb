module DataForge
  module Transformation
    class TransformationBase

      protected

      def with_writers(writers)
        writers.each { |writer| writer.open }
        begin
          yield writers
        ensure
          writers.each { |writer| writer.close }
        end
      end



      def with_writer(writer)
        writer.open
        begin
          yield writer
        ensure
          writer.close
        end
      end

    end
  end
end
