# I would've just patched the unpacked gem but
# it didn't play nice with Heroku :(
# 
class Flickr::Photos::Photo
  # Sets the meta information for a photo
  # 
  # Params
  # * title (defaults to current title)
  # * description (defaults to current description)
  def set_meta(options={})
    params = {
      :photo_id => self.id, 
      :title => self.title,
      :description => self.description
    }.merge(options)
    @flickr.send_request('flickr.photos.setMeta', params, :post)
    true
  end
end