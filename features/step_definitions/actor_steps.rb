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

When /^I am on the view page for actor "([^"]*)"$/ do |arg|
  @actor = Actor.find_by_name(arg)
  page.visit('/actors/' + @actor.id.to_s)
end

Then /^The actor "([^"]*)" should be destroyed$/ do |arg|
  assert (Actor.find_by_name(arg) == nil)
end