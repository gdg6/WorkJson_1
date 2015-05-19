Rails.application.routes.draw do

  resources :characters, :except => [:destroy, :edit]

  resources :tags, :except => [:destroy]

  resources :comments

  resources :events

  resources :users, :only => [:destroy]

  root :to => "events#index"

  get 'login' => 'sessions#new', as: :login
  post 'login_by_social' => 'sessions#create_by_social'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  get 'registration' => 'users#new', as: :registration
  post 'registration' => 'users#create'
  post 'getCities'  => 'cities#index'

  post 'getEventByCityAndCharacter' => 'events#getEventByCityAndCharacter'

  get 'getEventsByDateWithCountAndTag' => 'events#getEventsByDateWithCountAndTag' #!
  get 'getEventsByMounthWithCountAndTag' => 'events#getEventsByMounthWithCountAndTag'
  get 'getEventsByTagWithCount' => 'events#getEventsByTagWithCount'

  get 'getFavoriteEvents' => 'favorities#index', :as => :getFavotityEvents
  post 'addFavoriteEvent' => 'favorities#create' # only event_id
  post 'deleteFavoriteEvent' => 'favorities#destroy' #id

  post 'EditPasswordForUserId' => 'users#update_password'
  post 'getCityForUserId' => 'users#getCity'
  post 'setCityForUserId' => 'users#setCity'
  post 'getCharacterName' => 'users#getCharacterName'
  post 'setCharacterName' => 'users#setCharacterName'
  post 'setLogin' => 'users#setLogin'

  post 'addAdminByPK' => 'users#addAdmin'
  post 'deleteAdminByPK' => 'users#deleteAdmin'

  post 'getDailyPost' => 'daily_posts#show'
  post 'setDailyPost' => 'daily_posts#update'

  get '*unmatched_route', :to => 'application#not_found_404'
  post '*unmatched_route', :to => 'application#not_found_404'

end
