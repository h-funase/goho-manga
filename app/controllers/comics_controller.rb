class ComicsController < ApplicationController
  before_action :set_comic, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  
  def index
    @comics = Comic.includes(:user)
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

  end

  private
  def comic_params
    params.require(:comic).permit(:title, :image, :text,:url).merge(user_id: current_user.id)


  end

  def set_tweet
    @comic = Comic.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


end
