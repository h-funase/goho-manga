class EpisodesController < ApplicationController
  before_action :set_comic, except: [:update]
  before_action :set_episode, except: [:new,:create]
  
  def new
    @episode = Episode.new
  end
  def create
    @episode = Episode.create!(story_number: episode_params[:story_number],url: episode_params[:url],comic_id: params[:comic_id])
    redirect_to @comic
  end

  def edit
    @story_number = @episode[:story_number]
    @url = @episode[:url]
  end

  def update
    @episode.update(episode_params)
  end

  def destroy
    @episode.destroy
    redirect_to @comic
  end

  private
  def episode_params
    params.require(:episode).permit(:story_number,:url)
  end

  def set_comic
    @comic = Comic.find(params[:comic_id]) 
  end

  def set_episode
    @episode = Episode.find(params[:id])
  end
end
