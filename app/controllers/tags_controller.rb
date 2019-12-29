class TagsController < ApplicationController
  def edit
    @comic = Comic.find(params[:comic_id]) 
    @tag_list = @comic.tags.pluck(:name).join(",")
  end

  def update
    @comic = Comic.find(params[:comic_id]) 
    tag_list = params[:comic][:name].to_s.split(",")
      @comic.save_comics(tag_list)
      redirect_to @comic, notice: '記事を編集しました' 
    
  end
end
