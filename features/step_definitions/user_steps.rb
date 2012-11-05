### UTILITY METHODS ###

def create_visitor(email = "example@example.com")
  @email = email
  @password = "please"
  @name = "Testy McUserton"
  @visitor ||= { :name => @name, :email => @email,
    :password => @password, :password_confirmation => @password }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

### WHEN ###
When /^I sign out$/ do
  visit '/users/sign_out'
end

Given /^I'm a future user visiting the homepage$/ do
  visit root_path
end

When /^I click on "(.*?)"$/ do |link|
  click_link link
end

When /^I create a user with the following informations:$/ do |table|
  User.create!(table.hashes)
end

Given /^a registered user "(.*?)"$/ do |email|
  create_visitor(email)
  
  User.create!(@visitor)
end

Given /^I'm on the login page$/ do
  visit new_user_session_path
end

Given /^I fill in the log in form with correct informations$/ do
  step %(I fill in "user_email" with "#{@visitor[:email]}")
  step %(I fill in "user_password" with "#{@visitor[:password]}")
end

Then /^I should be logged in$/ do
  pending # express the regexp above with the code you wish you had
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end