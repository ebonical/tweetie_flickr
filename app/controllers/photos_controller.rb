class PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  
  def index
    @photos = Photo.all
  end
  
  def new
    @photo = Photo.new
  end
  
  # POST /photos.xml
  def create
    if @user = User.twitter_auth(params[:username], params[:password])
      
      @photo = @user.photos.new(params[:photo])
      @photo.image = params[:media] if params[:media]
      
      respond_to do |format|
        if @photo.save
          
          # Fork and wait about some time to fetch the tweets -
          # This obviously would have been better to use a
          # background job but that would have cost money :)
          if @photo.caption.blank?
            pid = fork do
              # wait 1 minute
              sleep 60 
              Photo.connection.reconnect!
              # get 'clean' photo
              photo = Photo.find(@photo.id)
              photo.fetch_tweet
              exit
            end
            Process.detach(pid)
            Photo.connection.reconnect!
          end
          
          flash[:notice] = "Photo saved."
          format.html { redirect_to(photos_url) }
          format.xml  { render :xml => @photo, :status => :created, :location => @photo }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        end
      end
    else
      render :nothing => true
    end
  end
end
