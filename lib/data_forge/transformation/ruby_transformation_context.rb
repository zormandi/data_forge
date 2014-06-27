module DataForge
  module Transformation
    class RubyTransformationContext

      def initialize(writers)
        @_writer_names = writers.map { |writer| writer.name }
        @_writers_hash = Hash[@_writer_names.zip writers]
        @_default_writer = writers.first
      end



      def output(record, options = {})
        if options.has_key? :to
          target_writer_names = *options[:to]
          target_writer_names.each do |target_writer_name|
            raise "Unknown target file '#{target_writer_name}' for `output` command" unless @_writer_names.include? target_writer_name
            @_writers_hash[target_writer_name].write record
          end
        else
          raise "Missing :to directive for `output` command in multiple file transformation" if @_writers_hash.count > 1
          @_default_writer.write record
        end
      end

    end
  end
end
