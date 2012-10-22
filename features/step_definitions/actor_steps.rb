Given /^the following actor exists:$/ do |table|
  # table is a | Alan Alda |pending
  actor_info = table.raw
  actor = FactoryGirl.build(:actor, :name => actor_info[1][0], :gender => actor_info[1][1], :dob => actor_info[1][2])
end

When /^I go to the actors page$/ do
  page.visit('/actors')
end

Then /^I should see "([^"]*)"$/ do |arg|
  page.has_content?(arg)
end
