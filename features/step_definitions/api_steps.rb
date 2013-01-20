Then /^the last reponse shouldn't contain any error$/ do 
  ActiveSupport::JSON.decode(last_response.body)["error"].should_not be_present
end

When /^I post the following to authenticate through the API:$/ do |table|
  params = {}
  table.rows.each {|el| params = {el.first => el.last}.merge(params)}

  send 'post', '/users/sign_in', params
end

Given /^I accept JSON$/ do
  header 'Accept', 'application/json'
end

Given /^I use the api "(.*?)"$/ do |version|
  @api_version = version
end

Given /^I sign in through the api$/ do
  step "I accept JSON"

  step "I post the following to authenticate through the API:", table(%{
    | field           | value             |
    | user[email]     | #{@user.email}    |
    | user[password]  | #{@user.password} |
  })

  @auth_token = ActiveSupport::JSON.decode(last_response.body)["auth_token"]
end

Then /^I should have received an authentication token$/ do
  ActiveSupport::JSON.decode(last_response.body)["auth_token"].should be_present
end

When /^I'm on the page of family through the api$/ do
  visit "/api/#{@api_version}/family?auth_token=#{@auth_token}"
end