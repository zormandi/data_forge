require 'optparse'

module DataForge
  module CLI
    class Options

      def self.parse(args, output = STDOUT)
        args = args.dup

        options = new

        OptionParser.new do |opts|
          opts.default_argv = args
          opts.banner = "Usage: [bundle exec] forge [options] command_script.rb"

          opts.separator ""
          opts.separator "Options:"

          opts.on("-Uname=value",
                  /^(?<name>\w+)=(?<value>\S+)$/,
                  "User-defined parameter value to be passed to the command script.",
                  "Can be specified multiple times (with a different name).") do |_, name, value|
            options.user_params[name.to_sym] = value
          end

          opts.separator ""
          opts.separator "Common options:"

          opts.on_tail("-h", "--help", "Show this message") do
            output.puts opts
            options.execute = false
          end

          opts.on_tail("-v", "--version", "Show version information") do
            output.puts "DataForge, version #{DataForge::VERSION}"
            options.execute = false
          end
        end.parse!

        if options.execute
          raise "No command file specified" if args.empty?
          raise "More than one command file specified" unless args.size == 1
          options.command_file = args.first
        end

        options
      end



      attr_accessor :command_file, :execute, :user_params



      def initialize
        @execute = true
        @user_params = {}
      end

    end
  end
end
