class ComicsController < ApplicationController
  before_action :set_comic, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  
  def index
    @comics = Comic.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @comic = Comic.new
  end

  def create
    Comic.create(comic_params)
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
  end

  def search
    @comics = Comic.search(params[:keyword])
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :image, :text,:url).merge(user_id: current_user.id)


  end

  def set_comic
    @comic = Comic.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
