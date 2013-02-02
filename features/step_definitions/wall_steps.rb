When /^I create a new post "(.*?)"$/ do |message|
  within '#posts' do
    click_link 'Post a message'
  end

  page.find(".new-post").should be_visible

  within '.new-post' do
    fill_in 'message', with: message

    click_button 'Post!'
  end
end

Then /^I should a post containing "(.*?)"$/ do |message|
  within ".posts-list" do
    page.should have_content(message)
  end
end