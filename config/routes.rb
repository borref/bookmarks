Rails.application.routes.draw do
  root to: 'bookmarks#index'
  resources :bookmarks
  get 'search', to: 'search#index'
end
