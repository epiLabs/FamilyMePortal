### UTILITY METHODS ###
def create_user email, password
  @password = password
  @email = email

  @user = User.create(email: email, password: password, password_confirmation: password)
  
  @user
end

def create_visitor(email = "toto42@toto.fr")
  @email = email
  @password = "toto42"
  @visitor ||= { :email => @email, :password => @password, :password_confirmation => @password }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

Given /^I accept JSON$/ do
  header 'Accept', 'application/json'
end

Given /^I'm logged out$/ do
  @visitor = nil
  @user = nil
  click_link "Logout"
end

Given /^A registered user "(.*?)"$/ do |email|
  create_user email
end

Given /^I'm a logged in user$/ do
  step %(a registered user "toto@el.loco")

  visit new_user_session_path

  step "I fill in the log in form with correct informations"

  step %(I press "Sign in")

  @user = User.last
end

When /^I visit the homepage$/ do
  visit root_path
end

Then /^I should see the backend$/ do
  within ('.container') do
    page.should have_content("Backend")
  end
end

Then /^I should see a form to create my family$/ do
  page.should have_content('create a family')
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
  
  create_user email, @visitor[:password]
end

Given /^I'm on the login page$/ do
  visit new_user_session_path
end

Given /^I fill in the log in form with (correct|wrong) informations$/ do |correct|
  step %(I fill in "user_email" with "#{@visitor[:email]}")

  if correct == "correct"
    step %(I fill in "user_password" with "#{@visitor[:password]}")
  else
    step %(I fill in "user_password" with "A_WRONG_PASSWORD")
  end
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
