module DataForge
  module File
    class Archiver
      class Strategy
        class Move

          def self.from_options(options)
            valid_options = ValidOptions.new "archive", to: nil, with_prefix: "", with_suffix: ""
            valid_options.import options

            new valid_options[:to], valid_options[:with_prefix], valid_options[:with_suffix]
          end



          attr_reader :archive_directory



          def initialize(archive_directory, prefix, suffix)
            @archive_directory, @prefix, @suffix = archive_directory, prefix, suffix
          end



          def execute(file_names)
            file_names.each do |original_file_name|
              extension = ::File.extname original_file_name
              basename = ::File.basename original_file_name, extension
              new_file_name = sprintf '%s%s%s%s', @prefix, basename, @suffix, extension

              FileUtils.move original_file_name, ::File.join(archive_directory, new_file_name)
            end
          end

        end
      end
    end
  end
end
