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
  get 'users/new_edit_username', to: 'users#new_edit_username'
  get 'users/new_edit_phone', to: 'users#new_edit_phone'
  get 'users/new_edit_email', to: 'users#new_edit_email'
  get 'users/new_edit_password', to: 'users#new_edit_password'

  patch 'users/edit_name', to: 'users#edit_name'
  patch 'users/edit_username', to: 'users#edit_username'
  patch 'users/edit_phone', to: 'users#edit_phone'
  patch 'users/edit_email', to: 'users#edit_email'
  patch 'users/edit_password', to: 'users#edit_password'

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
