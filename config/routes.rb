Rails.application.routes.draw do
  root to: 'bookmarks#index'
  resources :bookmarks
  get 'search', to: 'search#index'

  # API

  namespace :api do
    resources :bookmarks, except: [:new, :edit]
  end
end
