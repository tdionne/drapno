# == Schema Information
#
# Table name: dreams
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  story          :text
#  story_html     :text
#  dreamer_id     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  delta          :boolean(1)      default(TRUE), not null
#  location       :string(255)
#  dreamt_on      :date
#  ratings_count  :integer(4)      default(0), not null
#  average_rating :decimal(5, 3)   default(0.0), not null
#  comments_count :integer(4)      default(0), not null
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dream do
  describe "associations" do
    it { should belong_to(:dreamer) }
    it { should have_many(:appearances) }
    it { should have_many(:ratings) }
    it { should have_many(:raters) }
    it { should have_many(:comments) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:story) }
    it { should validate_presence_of(:dreamer_id) }
  end
end
