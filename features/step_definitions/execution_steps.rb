When(/^DataForge is run with no argument$/) do
  invoke_script_with_argument ""
end


When(/^DataForge is run with the "(.*?)" argument(?:s)?$/) do |argument|
  invoke_script_with_argument argument
end


When(/^the command script is executed$/) do
  execute_command_script
end


Then(/^the process should exit successfully$/) do
  result_code.should eq(0), "Expected script exit code to be 0, but received #{result_code}"
end


Then(/^the process should exit with an error$/) do
  result_code.should eq(1), "Expected script exit code to be 1, but received #{result_code}"
end


Then(/^the output should contain:$/) do |message|
  output.should include message
end


Then(/^the error message should contain:$/) do |message|
  error_output.should include message
end
