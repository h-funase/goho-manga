class ComicsController < ApplicationController
  before_action :set_comic, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  
  def index
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
    # binding.pry
    @comic = Comic.new(comic_params)
    @comic.save
    redirect_to(root_path)
    tag_list = params[:tag_name].split(",")
    if @comic.save
      @comic.save_comics(tag_list)
    end
  end

  def destroy
    comic = Comic.find(params[:id])
    comic.destroy
  end

  def edit

  end

  def update
    comic = Comic.find(params[:id])
    comic.update(comic_params)
  end

  def show
    @comment = Comment.new
    @comments = @comic.comments.includes(:user)
    @like = Like.new
  end

  def search
    
    @comics = Comic.search(params[:keyword])
  
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :image, :text,:url, :tag_list).merge(user_id: current_user.id)
  end

  def set_comic
    @comic = Comic.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
