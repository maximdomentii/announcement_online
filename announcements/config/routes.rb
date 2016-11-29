Rails.application.routes.draw do
  root 'pages#home'

  get    '/help',        to: 'pages#help'
  get    '/about',       to: 'pages#about'
  get    '/contact',     to: 'pages#contact'
  get    'pages/search', to: 'pages#search'
  get    'pages/get_current_user_announcements', to: 'pages#get_current_user_announcements'

  get    '/signup',      to: 'users#new'

  get    '/login',       to: 'sessions#new'
  post   '/login',       to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'

  resources :users

  resource :announcements do
    resource :ratings
    resource :images
  end

  resources :categories do
    resource :announcements
  end

end
