Rails.application.routes.draw do
  devise_for :users
  root to: "comics#index"
  resources :comics do
    # resources :likes, only: [:create, :destroy]   
    resources :episodes, only: [:new,:create,:edit,:update,:destroy]
    resource :tags, only: [:edit,:update]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  post   '/like/:comic_id' => 'likes#like',   as: 'like'
  delete '/like/:comic_id' => 'likes#unlike', as: 'unlike'
  resources :users, only: :show
end
