module DataForge
  module CLI
    class Main

      def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end



      def execute!
        options = CLI.parse_options @argv, @stdout
        load options.command_script if options.execute
      rescue Exception => e
        @stderr.puts "ERROR: " + e.message
        @kernel.exit 1
      end

    end
  end
end
