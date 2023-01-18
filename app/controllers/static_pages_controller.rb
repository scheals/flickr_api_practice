require 'flickr'

class StaticPagesController < ApplicationController
  def index
    @flickr_id = params[:user_id]
    return unless @flickr_id

    flickr = Flickr.new
    photos = flickr.people.getPhotos(user_id: @flickr_id, per_page: 30)
    @photo_urls = photos.map { |photo| Flickr.url(photo) }
  end
end
