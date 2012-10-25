When /^I go to the "([^"]*)" index page$/ do |arg|
  page.visit('/' + arg)
end

When /^I should see date "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I follow link "([^"]*)"$/ do |arg|
  click_link arg
end

Then /^I should see message "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I press button "([^"]*)"$/ do |arg|
  click_button arg
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with=>arg2
end

Given /^I am on the new "([^"]*)" page$/ do  |arg|
  page.visit('/' + arg + '/new')
end

When /^I fill in date with month "([^"]*)", day "([^"]*)", and year "([^"]*)"$/ do |arg1, arg2, arg3|
  page.select arg1, :from => "selected_date[value(2i)]"
  page.select arg2, :from => "selected_date[value(3i)]"
  page.select arg3, :from => "selected_date[value(1i)]"
end