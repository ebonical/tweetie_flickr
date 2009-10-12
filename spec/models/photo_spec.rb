# == Schema Information
#
# Table name: photos
#
#  id                :integer         not null, primary key
#  flickr_id         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  twitter_status_id :string(255)
#  caption           :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attributes = {
      :user_id => 1, 
    }
  end

  it "should create a new instance given valid attributes" do
    Photo.create!(@valid_attributes)
  end
  
  describe "hashtags" do
    it "should be good with nil" do
      photo = Photo.new
      photo.tags.should be_empty
    end
    
    it "should pull hashtags as tags for photo" do
      photo = Photo.new(:caption => "Hello #world what's new?")
      photo.tags.should == ['world']
    end
    
    it "should pull more than 1" do
      photo = Photo.new(:caption => '#more #than #one')
      photo.tags.should == %w(more than one)
    end
    
    it "should only pull valid parts of tags" do
      photo = Photo.new(:caption => '#first-than #this_is_good\'s #1 #nas.ty')
      photo.tags.should == %w(first this_is_good 1 nas)
    end
  end
end
