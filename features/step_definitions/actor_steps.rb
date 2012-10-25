Given /^the following actors exist:$/ do |table|
  # table is a | Robert Altman |pending
  table.hashes.each do |actor_info|
    actor = FactoryGirl.create(:actor, :name => actor_info["Name"], :gender => actor_info["Gender"], :dob => actor_info["Dob"])
  end
end

Given /^the following actor exists:$/ do |table|
  # table is a | Alan Alda |pending
  actor_info = table.raw
  actor = FactoryGirl.create(:actor, :name => actor_info[1][0], :gender => actor_info[1][1], :dob => actor_info[1][2])
end

When /^I go to the actors page$/ do
  page.visit('/actors')
end

Then /^I should see actor "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I add a duplicate actor  with name "([^"]*)" and gender "([^"]*)"$/ do |arg1, arg2|
  begin
    dup_actor = FactoryGirl.create(:actor, :name => arg1, :gender => arg2)
  rescue ActiveRecord::RecordInvalid => invalid
    @dup_error = invalid
  end
end

Then /^The actor should be invalid$/ do
  assert (@dup_error.to_s.include? "Name has already been taken")
end

When /^I add an actor with no gender$/ do
  begin
    FactoryGirl.create(:actor, :name => "foo name", :gender => nil)
  rescue ActiveRecord::RecordInvalid => invalid
    @gender_error = invalid
  end
end

Then /^The actor should be invalid due to missing gender$/ do
  assert (@gender_error.to_s.include? "Gender can't be blank")
end

When /^I fill in actor "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with=>arg2
end

When /^I fill in actor date of birth with month "([^"]*)", day "([^"]*)", and year "([^"]*)"$/ do |arg1, arg2, arg3|
  page.select arg1, :from => "selected_date[value(2i)]"
  page.select arg2, :from => "selected_date[value(3i)]"
  page.select arg3, :from => "selected_date[value(1i)]"
end

When /^I press actor button "([^"]*)"$/ do |arg|
  click_button arg
end

Then /^I should see actor message "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I go to the actors index page$/ do
  page.visit('/actors')
end

Given /^I am on the new actor page$/ do
  page.visit('/actors/new')
end

When /^I should see actor date of birth "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I follow actor link "([^"]*)"$/ do |arg|
  click_link arg
end