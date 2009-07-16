require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dreamer do
  describe "associations" do
    it { should have_many(:dreams) }
    it { should have_many(:appearances) }    
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
end
