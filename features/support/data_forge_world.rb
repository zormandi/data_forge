require 'open3'

class DataForgeWorld

  COMMAND_SCRIPT_FILE = "command_script.rb"

  attr_reader :output, :error_output, :result_code



  def initialize(working_directory)
    @working_directory = working_directory
  end



  def save_command_script(content)
    save_file COMMAND_SCRIPT_FILE, content
  end



  def save_file(file_name, content)
    File.open(File.join(@working_directory, file_name), "w:UTF-8") { |file| file.write content }
  end



  def read_file(file_name)
    File.read File.join(@working_directory, file_name)
  end



  def file_exists?(file_name)
    File.exists? File.join(@working_directory, file_name)
  end



  def execute_command_script
    invoke_script_with_argument COMMAND_SCRIPT_FILE
  end



  def invoke_script_with_argument(argument)
    @output, @error_output, status = Open3.capture3("bundle exec forge #{argument}")
    @result_code = status.exitstatus
    unless @error_output.empty? and @result_code.zero?
      puts "output: #{@output}"
      puts "error: #{@error_output}"
      puts "exit status: #{@result_code}"
    end
  end

end
