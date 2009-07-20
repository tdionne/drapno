class Page < ActiveRecord::Base
  validates_presence_of :title, :permalink, :content
  
  before_save :generate_html, :if => :content_changed?
  
  def generate_html
    self.content_html = RedCloth.new(self.content).to_html
  end
end
