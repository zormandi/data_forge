module DataForge
  module CLI

    autoload :Main, 'data_forge/cli/main'
    autoload :Options, 'data_forge/cli/options'


    class << self

      attr_reader :command_script, :user_params



      def parse_options(args, stdout)
        Options.parse(args, stdout).tap do |options|
          @command_script = options.command_script
          @user_params = options.user_params
        end
      end

    end

  end
end
