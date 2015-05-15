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

  get 'getEventsByDateWithCountAndTag' => 'events#getEventsByDateWithCountAndTag' #!
  get 'getEventsByMounthWithCountAndTag' => 'events#getEventsByMounthWithCountAndTag'
  get 'getEventsByTagWithCount' => 'events#getEventsByTagWithCount'

  get 'getFavoriteEvents' => 'favorities#index', :as => :getFavotityEvents #params: user_id and count
  post 'addFavoriteEvent' => 'favorities#create'
  post 'deleteFavoriteEvent' => 'favorities#destroy'

  post 'EditPasswordForUserId' => 'users#update_password'
  post 'getCityForUserId' => 'users#getCity'
  post 'setCityForUserId' => 'users#setCity'
  post 'getCharacterName' => 'users#getCharacterName'
  post 'setCharacterName' => 'users#setCharacterName'
  post 'setLogin' => 'users#setLogin'

  post 'addAdminByPK' => 'users#addAdmin'
  post 'deleteAdminByPK' => 'users#deleteAdmin'

  get 'getDailyPost' => 'daily_posts#show'
  post 'setDailyPost' => 'daily_posts#update'

  get '*unmatched_route', :to => 'application#not_found_404'
  post '*unmatched_route', :to => 'application#not_found_404'

end
