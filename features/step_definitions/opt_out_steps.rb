Given /^I have appeared in a dream with the email address "([^\"]*)"$/ do |email|
  dreamer = Dreamer.create!(:email => 'dreamer@example.com', :name => 'Dreamer', :password => 'pass-word', :password_confirmation => 'pass-word')
  dreamer.confirm_email!
  d = dreamer.dreams.create!(:title => 'Example', :story => 'A dream of dreams')
  d.appearances.create(:email => email, :name => email.split('@').first, :role => 'apparition', :should_be_notified => '1')
end


When /^I follow the opt out link$/ do
  a = last_email_sent.body.match(/http:\/\/example.com\/opt_outs\/(.*)\s/)
  visit a[0].strip
end

Given /^I followed the opt out link$/ do
  When %{I follow the opt out link}
end

Given /^I pressed "([^\"]*)"$/ do |button|
  When %{I press "#{button}"}
end
