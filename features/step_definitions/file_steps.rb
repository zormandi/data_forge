Then /^the file "([^"]*)" should be empty$/ do |file_name|
  step %Q(the file "#{file_name}" should contain exactly:), ""
end


Then /^the file "([^"]*)" should contain in "([^"]*)" encoding exactly:$/ do |file_name, encoding, content|
  prep_for_fs_check { expect(IO.read(file_name, encoding: encoding).encode("UTF-8", encoding)).to eq content }
end
