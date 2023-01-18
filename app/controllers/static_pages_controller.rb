require 'flickr'

class StaticPagesController < ApplicationController
  def index
    @user_id = params[:user_id]
    return unless @user_id

    flickr = Flickr.new

    begin
      photos = flickr.people.getPublicPhotos(user_id: @user_id, per_page: 30)
    rescue StandardError => e
      flash.now[:error] = 'Could not find a user with given ID!'
      render :index, status: :unprocessable_entity
      return
    end

    @photo_urls = photos.map { |photo| Flickr.url(photo) }
  end
end
