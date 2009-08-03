Given /^"([^\"]*)" is an admin user$/ do |email|
  d = Dreamer.find_by_email(email)
  d.update_attribute :role, 'admin'
end

Given /^the following reports exist on the first comment$/ do |table|
  # table is a Cucumber::Ast::Table
  c = Comment.first
  d = Dreamer.first
  table.hashes.each do |hash|
    c.reports.create(hash.merge(:reporter_id => d.id))
  end
end
