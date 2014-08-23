require 'open3'

module DataForge
  module Shell

    def self.exec(command)
      Open3.capture3 command
    end



    def self.exec!(command)
      out, err, status = exec command
      if status.success?
        return out, err, status
      else
        raise CommandError.new out, err, status.exitstatus
      end
    end



    class CommandError < StandardError

      def initialize(output = "", error = "", exit_status = nil)
        super "Shell command execution failed\n" +
                "#{@message}\n" +
                "Output: #{output}\n" +
                "Error: #{error}\n" +
                "Exit status: #{exit_status}\n"
      end

    end

  end
end
