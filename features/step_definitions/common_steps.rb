When /^I run "([^\"]*)"$/ do |command|
  system("cd #{@current_directory} && #{command}").should be_true
end

When /^I add "([^\"]*)" to file "([^\"]*)"$/ do |content, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.open(path, 'a') { |f| f.write(content + "\n") }
end

Then /^I should see the following files$/ do |table|
  table.raw.flatten.each do |path|
    File.should exist(File.join(@current_directory, path))
  end
end

Then /^I should see "(.*)" in file "([^\"]*)"$/ do |content, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.readlines(path).join.should include(content)
end

Then /^I should not see "(.*)" in file "([^\"]*)"$/ do |content, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.readlines(path).join.should_not include(content)
end

