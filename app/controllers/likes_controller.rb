class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = current_user.likes.new(comic_id: @comic.id)
  
    # @like = current_user.likes.create(comic_id: params[:comic_id])
    # redirect_back(fallback_location: root_path)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(comic_id: @comic.id)
    # @like = Like.find_by(comic_id: params[:comic_id], user_id: current_user.id)
    like.destroy
    # redirect_back(fallback_location: root_path)
  end

  private
  def set_variables
    @comic = Comic.find(params[:comic_id])
    @id_name = "#like-link-#{@comic.id}"
  end
end
