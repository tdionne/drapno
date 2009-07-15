# General

Then /^I should see error messages$/ do
  assert_match /error(s)? prohibited/m, response.body
end

# Database

Given /^no dreamer exists with an email of "(.*)"$/ do |email|
  assert_nil Dreamer.find_by_email(email)
end

Given /^I signed up with "(.*)\/(.*)"$/ do |email, password|
  dreamer = Factory :dreamer,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end 

Given /^I am signed up and confirmed as "(.*)\/(.*)"$/ do |email, password|
  dreamer = Factory :email_confirmed_dreamer,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end

# Session

Then /^I should be signed in$/ do
  assert controller.signed_in?
end

Then /^I should be signed out$/ do
  assert ! controller.signed_in?
end

When /^session is cleared$/ do
  request.reset_session
  controller.instance_variable_set(:@_current_user, nil)
end

# Emails

Then /^a confirmation message should be sent to "(.*)"$/ do |email|
  dreamer = Dreamer.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [dreamer.email], sent.to
  assert_match /confirm/i, sent.subject
  assert !dreamer.token.blank?
  assert_match /#{dreamer.token}/, sent.body
end

When /^I follow the confirmation link sent to "(.*)"$/ do |email|
  dreamer = Dreamer.find_by_email(email)
  visit new_dreamer_confirmation_path(:dreamer_id => dreamer, :token => dreamer.token)
end

Then /^a password reset message should be sent to "(.*)"$/ do |email|
  dreamer = Dreamer.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [dreamer.email], sent.to
  assert_match /password/i, sent.subject
  assert !dreamer.token.blank?
  assert_match /#{dreamer.token}/, sent.body
end

When /^I follow the password reset link sent to "(.*)"$/ do |email|
  dreamer = Dreamer.find_by_email(email)
  visit edit_dreamer_password_path(:dreamer_id => dreamer, :token => dreamer.token)
end

When /^I try to change the password of "(.*)" without token$/ do |email|
  dreamer = Dreamer.find_by_email(email)
  visit edit_dreamer_password_path(:dreamer_id => dreamer)
end

Then /^I should be forbidden$/ do
  assert_response :forbidden
end

# Actions

When /^I sign in( with "remember me")? as "(.*)\/(.*)"$/ do |remember, email, password|
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I check "Remember me"} if remember
  And %{I press "Sign In"}
end

When /^I sign out$/ do
  visit '/session', :delete
end

When /^I request password reset link to be sent to "(.*)"$/ do |email|
  When %{I go to the password reset request page}
  And %{I fill in "Email address" with "#{email}"}
  And %{I press "Reset password"}
end

When /^I update my password with "(.*)\/(.*)"$/ do |password, confirmation|
  And %{I fill in "Choose password" with "#{password}"}
  And %{I fill in "Confirm password" with "#{confirmation}"}
  And %{I press "Save this password"}
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end