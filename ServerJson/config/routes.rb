Rails.application.routes.draw do


  namespace :users do
    get 'omniauth_callbacks/facebook'
  end

  namespace :users do
    get 'omniauth_callbacks/vkontakte'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :destroy]

  resources :comments

  resources :events


  root :to => "events#index"

  get 'eventTest' => 'events#test', as: :eventTest
  get 'login'=>'sessions#new', as: :login
  post 'login'=>'sessions#create'
  get 'logout'=>'sessions#destroy', as: :logout

end
