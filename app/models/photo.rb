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

class Photo < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
  
  after_save :upload_to_flickr
  after_save :update_flickr_description
  
  attr_accessor :image
  
  def flickr_api
    @flickr_api ||= Flickr.new(FLICKR.merge(:token => user.flickr_token))
  end
  
  def uploaded?
    ! flickr_id.blank?
  end
  
  def short_id
    Base58.encode(flickr_id.to_i)
  end
  
  def short_url
    "http://flic.kr/p/#{short_id}"
  end
  
  def fetch_tweet
    if twitter_status_id.blank? && user
      timeline = user.twitter_api.user_timeline
      # scan each tweet and match the short URL
      timeline.each do |tweet|
        if tweet.text.match(short_url)
          self.twitter_status_id = tweet.id
          self.caption = tweet.text
          return save
        end
      end
    end
  end
  
  def tweet_url
    "https://twitter.com/#{user.twitter_username}/status/#{twitter_status_id}" if user && twitter_status_id?
  end
  
  # pull hashtags from caption text
  def tags
    caption.to_s.scan(/#(\w+)/).flatten
  end
  
  def flickr_image
    @flickr_image ||= flickr_api.photos.find_by_id(flickr_id) rescue nil
  end
  
  def to_xml(*args)
    output = ""
    x = Builder::XmlMarkup.new(:target => output)
    x.instruct!
    x.photo do
      x.id id
      x.mediaurl short_url
    end
    output
  end
  
  private
  
  def upload_to_flickr
    if image && !uploaded?
      rsp = flickr_api.uploader.upload(image.path, 
              :title => Time.now.utc.strftime("%e %b %Y"), 
              :tags => "iphone", 
              :is_public => !user.test_user?
            )
      self.flickr_id = rsp.photoid.to_s
      save
    end
  end
  
  # Update the description on flickr
  def update_flickr_description
    if caption_changed? && flickr_image
      description = caption.to_s
      description += "\n\nTwitter: #{tweet_url}" if tweet_url
      flickr_image.set_meta(:description => description)
      flickr_image.set_tags(tags.join(',')) unless tags.empty?
    end
  end
end
