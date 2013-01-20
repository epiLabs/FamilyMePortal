module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^debug$/ do
  binding.pry
end

When /^I wait for "(.*?)" seconds$/ do |nb_seconds|
  sleep nb_seconds.to_f
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, content|
  fill_in field, :with => content
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |field, select_box|
  select(field, :from => select_box)
end

When /^I press "([^"]*)"$/ do |label|
  click_button(label)
end

When /^I choose "([^"]*)"$/ do |label|
  choose label
end

Then /^show me the page/ do
  save_and_open_page
end

When /^I don't fill in "([^"]*)"$/ do |label|
  fill_in label, :with => ""
end

When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I go to homepage/ do
  visit root_path
end

When /^I select a photo from my disk for "([^"]*)"$/ do |image_label|
  attach_file(image_label, "#{Rails.root}/app/assets/images/rails.png")
end

When /^I fill in the following fields:$/ do |table|
  table.rows.each do |el|
    fill_in el.first, :with => el.last
  end
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end
