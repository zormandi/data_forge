When(/^DataForge is run with the "(.*?)" argument$/) do |argument|
  invoke_script_with_argument argument
end


Then(/^the result should be success$/) do
  result_code.should eq(0), "The script run should have been successful, but wasn't"
end


Then(/^the output should contain:$/) do |message|
  output.should include message
end
