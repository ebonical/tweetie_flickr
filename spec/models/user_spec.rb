# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  twitter_username :string(255)
#  twitter_password :string(255)
#  flickr_user_id   :string(255)
#  flickr_token     :string(255)
#  test_user        :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :twitter_username => "value for username",
      :twitter_password => "value for password",
      :flickr_token => "value for token"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
