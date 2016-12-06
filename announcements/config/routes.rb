Rails.application.routes.draw do
  root 'pages#home'

  get    '/help',        to: 'pages#help'
  get    '/about',       to: 'pages#about'
  get    '/contact',     to: 'pages#contact'
  get    'pages/search', to: 'pages#search'
  get    'pages/get_current_user_announcements', to: 'pages#get_current_user_announcements'
  get    'pages/most_recent', to: 'pages#most_recent'
  get    'pages/most_viewed', to: 'pages#most_viewed'
  get    'pages/best_rated',  to: 'pages#best_rated'

  get    '/signup',      to: 'users#new'

  get    '/login',       to: 'sessions#new'
  post   '/login',       to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'

  get 'users/new_edit_name', to: 'users#new_edit_name'
  patch 'users/edit_name', to: 'users#edit_name'
  resources :users

  resource :announcements do
    resource :ratings
    resource :images
  end

  resources :categories do
    resource :announcements
  end

  get '*path', to: 'pages#not_found'

end
