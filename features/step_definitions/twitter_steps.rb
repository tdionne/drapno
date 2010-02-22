When /^I follow the stubbed oauth link to twitter$/ do
  stub_post('http://twitter.com/oauth/request_token', :response => File.read(File.join(Rails.root, "features", "support", "http_sessions", "twitter_access_token")))
  stub_post('http://twitter.com/oauth/access_token', :response => File.read(File.join(Rails.root, "features", "support", "http_sessions", "twitter_access_token")))
  stub_get('http://twitter.com/oauth/authorize?oauth_token=IPPshbCRL6G3FxX83DVv3ZgLP2A936cCHp6ht3REKk')
  click_link "twitter"
  visit "/oauth_consumers/twitter/callback?oauth_token=114716962-WoKVIBAiX8vyo4RoQdk8i0XdqICuuhpZmnko5CMd&oauth_verifier=tACBaflKWyVIuP9OxEneXPNEvaHl7B9DP3ziR9vj83Q"
end

Given /^I have authorised twitter for my account$/ do
  When %{I go to "the services page"}
  When %{I follow the oauth link to twitter}
end

Then /^I should have twitter credentials in the database$/ do
  controller.current_user.twitter.should_not be_nil
end

Then /^a background job should be set up to post to twitter$/ do
  Delayed::Job.first(:conditions => ['handler LIKE ?', "%update_twitter_without_send_later%"]).should_not be_nil
end

When /^I follow the redirect$/ do
  header("Host", "twitter.com")
  follow_redirect!
end