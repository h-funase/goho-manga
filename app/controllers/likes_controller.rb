class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = current_user.likes.new(comic_id: @comic.id)
    like.save
    respond_to do |format|
      format.js { flash[:notice] = "いいねリストに追加しました" }
    end
  end


  def unlike
    like = current_user.likes.find_by(comic_id: @comic.id)
    like.destroy
    respond_to do |format|
      format.js { flash[:notice] = "いいねリストから削除しました!" }
    end
  end

  private
  def set_variables
    @comic = Comic.find(params[:comic_id])
    @id_name = "#like-link-#{@comic.id}"
  end
end
