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
