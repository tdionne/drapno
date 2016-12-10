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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:permalink) }
    it { should validate_presence_of(:content) }
  end
  
  describe "generating HTML" do
    before(:each) do
      @page = Page.new(:title => 'Title', :permalink => 'title', :content => '*James*')
    end
    
    it "generates HTML before save" do
      @page.save!
      @page.content_html.should == '<p><strong>James</strong></p>'
    end
    
    it "checks whether the content has changed" do
      @page.expects(:content_changed?).returns(false)
      @page.save
    end
  end
end
