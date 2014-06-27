module DataForge
  class Application

    USAGE_INFORMATION = "Usage: forge [--help|--version|command script file]\n\n"\
                        "forge --help           Prints this page.\n"\
                        "forge --version        Prints version information.\n"\
                        "forge command_file.rb  Executes instructions in command_file.rb.\n"



    def run(args)
      validate_arguments args

      case args.first
        when "--help"
          $stdout.puts USAGE_INFORMATION
        when "--version"
          $stdout.puts "DataForge, version #{DataForge::VERSION}"
        else
          execute_command_file args.first
      end
    end



    def execute_command_file(command_file)
      validate_file_exists command_file
      load command_file
    end



    private

    def validate_arguments(args)
      unless args.count == 1
        if args.empty?
          $stderr.puts "ERROR: no command file specified\n\n"
        else
          $stderr.puts "ERROR: executing more than one command file is currently not supported\n\n"
        end
        $stderr.puts USAGE_INFORMATION
        exit false
      end
    end



    def validate_file_exists(command_file)
      unless ::File.exists? command_file
        $stderr.puts "ERROR: File '#{command_file}' does not exist"
        exit false
      end
    end

  end
end
