When(/^I display the new invitation form$/) do
  within '.invitations-list-header' do
    click_link 'Send a new invitation'
  end
end

Then(/^I should have an invitation pending$/) do
  within '#welcome-screen' do
    page.should have_selector('.invitation')
  end
end

When(/^I accept this invitation$/) do
  within '.invitation' do
    click_link 'Accept'
  end
end
