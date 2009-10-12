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

class User < ActiveRecord::Base
  has_many :photos, :dependent => :destroy
  
  def self.twitter_auth(username, password)
    User.find_by_twitter_username_and_twitter_password(username, password)
  end
  
  # return Twitter API object
  def twitter_api
    httpauth = Twitter::HTTPAuth.new(twitter_username, twitter_password)
    Twitter::Base.new(httpauth)
  end
  memoize :twitter_api
  
end
