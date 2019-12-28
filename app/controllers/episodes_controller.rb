class EpisodesController < ApplicationController
  
  def new
    @episode = Episode.new
    @comic = Comic.find(params[:comic_id]) 
  end

  def create
    # binding.pry
    @episode = Episode.create!(story_number: episode_params[:story_number],url: episode_params[:url],comic_id: params[:comic_id])
    redirect_to root_path
  end

  private
  def episode_params
    params.require(:episode).permit(:story_number,:url)
  end

  

end
