Given /^a family with the following members:$/ do |table|
  @family ||= Family.create()

  table.hashes.each do |informations|
    user = User.new informations
    user.family = @family
    user.save!
  end
end

When /^I visit my family page$/ do
  visit family_path
end

Then /^I should see a notice$/ do
  page.find("#flash_notice").should be_visible
end

Then /^It should create a family$/ do
  Family.last.should_not be_nil
end

Then /^I should be on my family index$/ do
  current_url.should == family_url
end

Then /^I should see an error$/ do
  page.find("#flash_error").should be_visible
end

Then /^I should be on the new family page$/ do
  current_url.should == family_url
end

Given /^I'm part of a family$/ do
  visit family_path
  
  step "I follow \"Create your family now\""

  @family = Family.last
end

When /^I'm on the index page of my family$/ do
  visit family_url
end

Then /^I should see myself on the family's user listing$/ do
  page.should have_content(@user.email)
end

Given /^the name of my family is "(.*?)"$/ do |name|
  @family.update_attributes(name: name)
end

Then /^my family should have (\d+) members?$/ do |nb|
  @family.users.count.should == nb.to_i
end