class ComicsController < ApplicationController
  before_action :set_comic, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]
  # before_action :ranks_set
  
  def index
    # @all_ranks = Comic.find(Like.group(:comic_id).order('count(comic_id) desc').limit(3).pluck(:comic_id))
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @comics = @tag.comics.order("created_at DESC").page(params[:page]).per(10)
    else
      @comics = Comic.includes(:user).order("created_at DESC").page(params[:page]).per(10)
    end
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    tag_list = params[:comic][:name].split(",")    
    @comic.save 
    if @comic.save
      @comic.save_comics(tag_list)  
      redirect_to(root_path)
    else
      render :new
      flash.notice = '投稿に失敗しました'
    end
  end

  def destroy
    comic = Comic.find(params[:id])
    comic.destroy
  end

  def edit
    @story_number = @comic.episodes.pluck(:story_number)
    @url = @comic.episodes.pluck(:url)
    @tag_list = @comic.tags.pluck(:name).join(",")
  end

  def update
    @comic = Comic.find(params[:id])
    @comic.update(comic_params)

    tag_list = params[:comic][:name].to_s.split(",")
    if @comic.update(comic_params)
      @comic.save_comics(tag_list)
      redirect_to @comic, notice: '記事を編集しました' 
    else
      render :edit 
    end
  end

  def show
    @comment = Comment.new
    @comments = @comic.comments.includes(:user)
    @like = Like.new
  end

  def search
    @comics = Comic.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end



  private
  def comic_params
    params.require(:comic).permit(:title, :image, :text, :tag_list, episodes_attributes:[:id,:url,:story_number]).merge(user_id: current_user.id)
  end

  def set_comic
    @comic = Comic.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  

  # def ranks_set
  #   @all_ranks = Comic.find(Like.group(:comic_id).order('count(comic_id) desc').limit(3).pluck(:comic_id))
  # end
end