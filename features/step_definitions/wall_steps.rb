When /^I create a new post "(.*?)"$/ do |message|
  click_link 'Add new post'

  fill_in 'Message', with: message

  click_button 'Save'
end

Then /^I should a post containing "(.*?)"$/ do |message|
  sleep 0.1
  page.current_path.should eq '/posts'

  within ".webapp" do
    page.should have_content(message)
  end
end

Then /^I shouldn't see a post containing "(.*?)"$/ do |arg1|
  within ".webapp" do
    page.should_not have_content(message)
  end
end

When /^I click on the cross to delete my post$/ do
  page.first('.delete-post').click
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

When /^I mouseover the first post$/ do
  within '.posts-list' do
    page.first('.post').trigger(:mouseover)
  end
end

Then /^I should see one hidden cross within the post$/ do
  within '.posts-list' do
    page.should have_selector('.delete-post', visible: false, count: 1)
  end
end

Then /^I shouldn't see any cross on the post$/ do
  page.first('.delete-post').should be_nil
end
