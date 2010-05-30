require 'factory_girl'

Factory.sequence :email do |n|
  "somebody#{n}@example.com"
end

Factory.define :dreamer do |u|
  u.name 'John Doe'
  u.email { Factory.next(:email) }
end

Factory.define :email_confirmed_dreamer, :class => Dreamer do |u|
  u.name 'John Doe'
  u.email { Factory.next(:email) }
  u.email_confirmed true
end
