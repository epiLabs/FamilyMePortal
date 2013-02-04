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
Then /^I shouldn't see a post containing "(.*?)"$/ do |arg1|
  within ".posts-list" do
    page.should_not have_content(message)
  end
end

When /^I click on the cross to delete my post$/ do
  step 'I mouseover the post'

  within '.posts-list' do
    page.all('.delete-post').first.click
  end
end

Then /^there should be (\d+) posts?$/ do |nb|
  Post.count.should == nb.to_i
end

Given /^another member of my family has created a post$/ do
  @other_user ||= create_user('other_user@yop.fr')
  @other_user.family = @family
  @other_user.save

  @post = @other_user.posts.new(message: "THIS IS ANOTHER MESSSAGE")
  @post.family = @family
  @post.save
end

When /^I mouseover the post$/ do
  within '.posts-list' do
    page.find('.post').trigger(:mouseover)
  end
end

Then /^I should see a hidden cross within the post$/ do
  within '.posts-list' do
    page.should have_selector('.delete-post')

    page.find('.delete-post').should_not be_visible
  end
end

Then /^I shouldn't see any cross on the post$/ do
  within '.posts-list' do
    page.should have_no_selector('.delete-post')
  end
end
