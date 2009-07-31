Given /^the following dreams exist:$/ do |table|
  dreamer = Dreamer.first
  table.hashes.each do |hash|
    dreamer.dreams.create!(hash)
  end
end
