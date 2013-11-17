When(/^DataForge is run with the "(.*?)" argument$/) do |argument|
  invoke_script_with_argument argument
end


When(/^the command script is executed$/) do
  execute_command_script
end


Then(/^the process should exit successfully$/) do
  result_code.should eq(0), "Expected script exit code to be 0, but received #{result_code}"
end


Then(/^the output should contain:$/) do |message|
  output.should include message
end
