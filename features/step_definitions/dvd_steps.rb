Given /^the following dvd exists:$/ do |table|
  # table is a | Robert Altman |pending
  dvd_info = table.raw
  dvd = FactoryGirl.create(:dvd, :name => dvd_info[1][0], :summary => dvd_info[1][1])
end

When /^I go to the dvds page$/ do
  page.visit('/dvds')
end

Then /^I should see dvd "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I add a duplicate dvd  with name "([^"]*)" and summary "([^"]*)"$/ do |arg1, arg2|
  begin
    dup_dvd = FactoryGirl.create(:dvd, :name => arg1, :summary => arg2)
  rescue ActiveRecord::RecordInvalid => invalid
    @dup_error = invalid
  end
end

Then /^The dvd should be invalid$/ do
  assert (@dup_error.to_s.include? "Name has already been taken")
end

When /^I add an dvd with no summary$/ do
  begin
    FactoryGirl.create(:dvd, :name => "foo name", :summary => nil)
  rescue ActiveRecord::RecordInvalid => invalid
    @gender_error = invalid
  end
end

Then /^The dvd should be invalid due to missing summary$/ do
  assert (@gender_error.to_s.include? "Summary can't be blank")
end

And /^I should see one actor for dvd "([^"]*)"$/ do |arg|
  assert Dvd.find_by_name(arg).actors.length == 1
end

And /^I should see one director for dvd "([^"]*)"$/ do |arg|
  assert Dvd.find_by_name(arg).director.valid?
end

Given /^I am on the new dvd page$/ do
  page.visit('/dvds/new')
end

When /^I fill in dvd "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with=>arg2
end
When /^I press dvd button "([^"]*)"$/ do |arg|
  click_button arg
end

Then /^I should see dvd message "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I should see dvd asin link for "([^"]*)"$/ do |arg|
  link = "http://www.amazon.com/o/ASIN/" + arg
  assert page.has_link?(arg, {:href => "http://www.amazon.com/o/ASIN/B000059H99"})
end

When /^I should not see dvd asin link for "([^"]*)"$/ do |arg|
  link = "http://www.amazon.com/o/ASIN/" + arg
  assert !page.has_link?(arg, {:href => "http://www.amazon.com/o/ASIN/B000059H99"})
end

And /^I select "([^"]*)" for the dvd director$/ do |arg|
  page.select arg, :from => "director_id"
end

And /^I should see the dvd director is "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

Then /^I should see (\d+) directors available for the dvd$/ do |arg|
  assert page.has_content?("Robert Altman")
  assert page.has_content?("Burt Metcalf")
end

And /^I should see (\d+) actors available for the dvd$/ do |arg|
  assert page.has_content?("Alan Alda")
  assert page.has_content?("Mike Farrel")
end

And /^I select "([^"]*)" for the dvd actor$/ do |arg|
  page.select arg, :from => "actors_ids"
end

And /^I should see the dvd actor is "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end
When /^I follow dvd link "([^"]*)"$/ do |arg|
  click_link arg
end