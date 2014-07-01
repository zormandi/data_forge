require 'optparse'

module DataForge
  module CLI
    class Options

      def self.parse(args, output = STDOUT)
        args = args.dup

        options = new

        OptionParser.new do |parser|
          parser.default_argv = args
          parser.banner = "Usage: [bundle exec] forge [options] command_script.rb"

          parser.separator ""
          parser.separator "Options:"

          parser.on("-Uname=value",
                  /^(?<name>\w+)=(?<value>\S+)$/,
                  "User-defined parameter value to be passed to the command script.",
                  "Can be specified multiple times (with a different name).") do |_, name, value|
            options.user_params[name.to_sym] = value
          end

          parser.separator ""
          parser.separator "Common options:"

          parser.on_tail("-h", "--help", "Show this message") do
            output.puts parser
            options.execute = false
          end

          parser.on_tail("-v", "--version", "Show version information") do
            output.puts "DataForge, version #{DataForge::VERSION}"
            options.execute = false
          end
        end.parse!

        if options.execute
          raise "No command script specified" if args.empty?
          raise "More than one command script specified" unless args.size == 1
          options.command_script = args.first
        end

        options
      end



      attr_accessor :command_script, :execute, :user_params



      def initialize
        @execute = true
        @user_params = {}
      end

    end
  end
end
