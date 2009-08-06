Given /^the following dreams exist:$/ do |table|
  dreamer = Dreamer.first
  table.hashes.each do |hash|
    dreamer.dreams.create!(hash)
  end
end

Given /^the following comments exist on "([^\"]*)":$/ do |dream_title, table|
  dream = Dream.find_by_title(dream_title)
  dreamer = Dreamer.first
  table.hashes.each do |hash|
    dream.comments.create!(hash.merge(:dreamer_id => dreamer.id))
  end
end

Then /^I should see a field to explain my reason$/ do
  response.should have_tag("textarea[id=comment_report_reason]")
end

Then /^an email should be sent to "([^\"]*)"$/ do |email|
  last_email_sent.to.include?(email).should be_true
end

