Rails.application.routes.draw do

  resources :tags

  resources :genre_tags

  resources :comments

  resources :events


  namespace :users do
    get 'omniauth_callbacks/facebook'
  end

  namespace :users do
    get 'omniauth_callbacks/vkontakte'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :destroy]

  root :to => "events#index"

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout


  get 'registration' => 'users#new', as: :registration
  post 'registration' => 'users#create'

  get 'getFavoriteEvents' => 'favorities#index', :as => :getFavotityEvents #params: user_id and count
  get 'testFavoriteEventsNew' => 'favorities#new'
  post 'addFavoriteEvent' => 'favorities#create'

  post 'EditPasswordForUserId' => 'users#update_password'


  post 'getCityForUserId' => 'users#getCity'
  post 'setCityForUserId' => 'users#setCity'
  post 'getCharacterName' => 'users#getCharacterName'
  post 'setCharacterName' => 'users#setCharacterName'

end
