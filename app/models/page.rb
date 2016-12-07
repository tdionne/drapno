# == Schema Information
#
# Table name: pages
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)
#  content      :text
#  content_html :text
#  permalink    :string(24)
#  created_at   :datetime
#  updated_at   :datetime
#

class Page < ActiveRecord::Base
  validates_presence_of :title, :permalink, :content
  
  before_save :generate_html
  
  def generate_html
    self.content_html = RedCloth.new(self.content).to_html
  end
end
