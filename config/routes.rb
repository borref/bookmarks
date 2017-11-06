Rails.application.routes.draw do
  root to: 'home#index'

  get 'legacy', to: 'bookmarks#index'
  resources :bookmarks
  get 'search', to: 'search#index'

  # API

  namespace :api do
    resources :bookmarks, except: [:new, :edit]
  end
end
