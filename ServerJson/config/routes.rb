Rails.application.routes.draw do

  resources :characters, :except => [:destroy, :edit]

  resources :tags, :except => [:destroy]

  resources :comments

  resources :events

  resources :users, :only => [:destroy]

  root :to => "events#index"

  #============ SESSIONS ============
  get 'login' => 'sessions#new', as: :login
  post 'login_by_social' => 'sessions#create_by_social'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout


  # =========== USERS ================
  get 'registration' => 'users#new', as: :registration
  post 'registration' => 'users#create'
  post 'getProfileInfo' => 'users#get_profile_info'
  post 'setPassword' => 'users#set_password'
  post 'setCity' => 'users#set_city'
  post 'setCharacter' => 'users#set_character'
  post 'addAdminByPK' => 'users#addAdmin'
  post 'deleteAdminByPK' => 'users#deleteAdmin'


  #=========== CITIES ===============
  post 'getCities'  => 'cities#index'


  #=========== EVENTS ===============
  post 'getEventByCityAndCharacter' => 'events#getEventByCityAndCharacter'
  post 'getEventsByDateWithCountAndTag' => 'events#getEventsByDateWithCountAndTag' #!
  post 'getEventsByMounthWithCountAndTag' => 'events#getEventsByMounthWithCountAndTag'
  post 'getEventsByTagWithCount' => 'events#getEventsByTagWithCount'


  #========== FAVORITIES EVENT ======
  get 'getFavoriteEvents' => 'favorities#index', :as => :getFavotityEvents
  post 'addFavoriteEvent' => 'favorities#create' # only event_id
  post 'deleteFavoriteEvent' => 'favorities#destroy' #id


  #========= DALY POST ==============
  post 'getDailyPost' => 'daily_posts#show'
  post 'setDailyPost' => 'daily_posts#update'


  #======== ERROR SERVER ===========
  get '*unmatched_route', :to => 'application#not_found_404'
  post '*unmatched_route', :to => 'application#not_found_404'

end
