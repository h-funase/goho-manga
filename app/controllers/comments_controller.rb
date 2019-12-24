class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/comics/#{comment.comic.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, comic_id: params[:comic_id])
  end
end
