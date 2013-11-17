require 'open3'

class DataForgeWorld

  attr_reader :output, :error_output, :result_code



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
