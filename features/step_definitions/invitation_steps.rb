Given /^the site is in invitation only mode$/ do
  ::INVITATION_ONLY = true
end


Given /^the site is not in invitation only mode$/ do
  ::INVITATION_ONLY = false
end

Given /^an invitation has been issued to "([^\"]*)"$/ do |email|
  Invitation.create!(:email => email, :first_name => email.split("@").first, :last_name => email.split("@").last)
end

When /^I follow the invitation link for "([^\"]*)"$/ do |email|
  i = Invitation.find_by_email!(email)
  visit sign_up_path(:code => i.invitation_code)
end

Given /^I signed up with an invitation as "(.*)\/(.*)"$/ do |email, password|
  Given %{an invitation has been issued to "#{email}"}
  And %{I follow the invitation link for "#{email}"}
  And %{I fill in "Name" with "My Name"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Confirm password" with "#{password}"}
  And %{I press "Sign up"}
end
