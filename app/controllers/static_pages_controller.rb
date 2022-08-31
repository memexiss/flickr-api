class StaticPagesController < ApplicationController
  require 'flickr'
  
  def index
    flickr = Flickr.new ENV['FLICKR_API_KEY'], "4c1f6015e6502fba"

    if params[:user_id] && params[:user_id].empty?
      flash[:alert] = "Please enter a valid user ID!"
    elsif params[:user_id]
      begin
        @photos = flickr.photos.search(user_id: params[:user_id])
        flash[:alert] = nil
      rescue Flickr::FailedResponse => e
        flash[:alert] = "Error : #{e.msg}"
      end
    end
  end
end