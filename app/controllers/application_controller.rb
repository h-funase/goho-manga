class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :ranks_set

  private
  def ranks_set
    @all_ranks = Comic.find(Like.group(:comic_id).order('count(comic_id) desc').limit(3).pluck(:comic_id))
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
