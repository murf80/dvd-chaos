Given /^the following actor exists:$/ do |table|
  # table is a | Alan Alda |pending
  actor_info = table.raw
  actor = FactoryGirl.create(:actor, :name => actor_info[1][0], :gender => actor_info[1][1], :dob => actor_info[1][2])
end

When /^I go to the actors page$/ do
  page.visit('/actors')
end

Then /^I should see "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
  puts page.body.inspect
end

When /^I add a duplicate actor  with name "([^"]*)"$/ do |arg|
  @dup_detected = true
  begin
    dup_actor = FactoryGirl.create(:actor, :name => arg)
  rescue ActiveRecord::RecordInvalid => invalid
    @dup_detected = false
  end
end

Then /^The actor should be invalid$/ do
  assert !@dup_detected
end