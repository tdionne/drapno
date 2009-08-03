namespace :db do
  task :pages => :environment do
    pages = Dir.glob(File.join(RAILS_ROOT, "db", "pages", "*.textile"))
    pages.each do |page_file|
      permalink = File.basename(page_file, ".textile")
      page = Page.find_or_create_by_permalink(permalink)
      page.content = File.read(page_file)
      page.save!
    end
  end
  
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    Dreamer.populate 100 do |dreamer|
      dreamer.email = Faker::Internet.email
      dreamer.email_confirmed = true
      dreamer.name = Faker::Name.name
      dreamer.gender = ['Male', 'Female'][rand(2)]
      dreamer.encrypted_password = Populator.words(1)
    end
    
    dreamer_ids = Dreamer.all(:select => 'id').collect(&:id)
    
    Dream.populate 300 do |dream|
      dream.title = Populator.words(3..6)
      dream.story = Populator.paragraphs(2..7)
      dream.dreamer_id = dreamer_ids[rand(dreamer_ids.size)]
      dream.location = Populator.words(1..3)
      dream.dreamt_on = rand(75).days.ago
    end
    
    Dream.find_each do |dream|
      dream.tag_list = Populator.words(3..8).split(" ").join(",")
      dream.save
      
      rand(5).times do
        if rand(150).even?
          dreamer = Dreamer.find(dreamer_ids[rand(dreamer_ids.size)])
          dream.appearances.create(:apparition_id => dreamer.id, :email => dreamer.email, :name => dreamer.name, :role => Populator.words(1))
        else
          dream.appearances.create(:email => Faker::Internet.email, :name => Faker::Name.name, :role => Populator.words(1))
        end
      end
    end
    
    Dreamer.find_each do |dreamer|
      Dream.find_each do |dream|
        Rating.create!(:rater => dreamer, :dream => dream, :score => rand(5))
      end
    end
    
  end
end