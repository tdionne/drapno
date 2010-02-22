# == Schema Information
#
# Table name: dreamers
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean(1)      not null
#  last_signed_in_at  :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(128)
#  location           :string(255)
#  gender             :string(10)
#  age_band           :string(8)
#  ratings_count      :integer(4)      default(0), not null
#  public_profile     :boolean(1)      default(TRUE)
#  role               :string(255)     default("user"), not null
#  public_alias       :string(63)
#  comments_count     :integer(4)      default(0), not null
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dreamer do
  describe "associations" do
    it { should have_many(:dreams) }
    it { should have_many(:appearances) }
    it { should have_many(:ratings) }
    it { should have_many(:comments) }
    it { should have_many(:comment_reports) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should_not allow_value('M').for(:gender) }
    it { should allow_value('Male').for(:gender) }
    it { should allow_value('Female').for(:gender) }
    Dreamer::AGE_BANDS.each do |band|
      it { should allow_value(band).for(:age_band) }
    end
    it { should_not allow_value('15').for(:age_band) }
  end
  
  describe "spotting facebook accounts" do
    it "returns true if we have a facebook id stored" do
      d = Dreamer.new
      d.facebook_id = '1234'
      d.has_facebook_account?.should be_true
    end
    
    it "returns false if we don't have a facebook id" do
      d = Dreamer.new
      d.has_facebook_account?.should be_false
    end
  end
end
