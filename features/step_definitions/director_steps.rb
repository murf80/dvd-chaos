Given /^the following director exists:$/ do |table|
  # table is a | Robert Altman |pending
  director_info = table.raw
  director = FactoryGirl.create(:director, :name => director_info[1][0], :gender => director_info[1][1], :dob => director_info[1][2])
end

Given /^the following directors exists:$/ do |table|
  # table is a | Robert Altman |pending
  table.hashes.each do |director_info|
    director = FactoryGirl.create(:director, :name => director_info["Name"], :gender => director_info["Gender"], :dob => director_info["Dob"])
  end
end

When /^I go to the directors page$/ do
  page.visit('/directors')
end

Then /^I should see director "([^"]*)"$/ do |arg|
  assert page.has_content?(arg)
end

When /^I add a duplicate director  with name "([^"]*)" and gender "([^"]*)"$/ do |arg1, arg2|
  begin
    dup_director = FactoryGirl.create(:director, :name => arg1, :gender => arg2)
  rescue ActiveRecord::RecordInvalid => invalid
    @dup_error = invalid
  end
end

Then /^The director should be invalid$/ do
  assert (@dup_error.to_s.include? "Name has already been taken")
end

When /^I add an director with no gender$/ do
  begin
    FactoryGirl.create(:director, :name => "foo name", :gender => nil)
  rescue ActiveRecord::RecordInvalid => invalid
    @gender_error = invalid
  end
end

Then /^The director should be invalid due to missing gender$/ do
  assert (@gender_error.to_s.include? "Gender can't be blank")
end

When /^I am on the view page for director "([^"]*)"$/ do |arg|
  @director = Director.find_by_name(arg)
  page.visit('/directors/' + @director.id.to_s)
end

Then /^The director "([^"]*)" should be destroyed$/ do |arg|
  assert (Director.find_by_name(arg) == nil)
end