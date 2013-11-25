Given(/^the following command script:$/) do |script|
  save_command_script script
end


Given(/^a(?:n)? "([^"]*)" file containing:$/) do |file_name, content|
  save_file file_name, content
end


Then(/^there should be a(?:n)? "([^"]*)" file containing:$/) do |file_name, content|
  step %Q(there should be a "#{file_name}" file)
  read_file(file_name).chomp.should == content
end


Then(/^there should be a(?:n)? "([^"]*)" encoded "([^"]*)" file containing:$/) do |encoding, file_name, content|
  step %Q(there should be a "#{file_name}" file)
  read_file(file_name, encoding).encode("UTF-8", encoding).chomp.should == content
end


Then(/^there should be a(?:n)? "([^"]*)" file$/) do |file_name|
  file_exists?(file_name).should be_true, "Expected file '#{file_name}' to exist"
end
