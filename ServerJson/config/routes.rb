Rails.application.routes.draw do

  resources :characters

  resources :tags

  resources :comments

  resources :events, :except=>[:index]

  resources :users, :only => [:destroy]

  root :to => 'application#not_found_404'

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
  post 'addAdminByPK' => 'users#add_admin'
  post 'deleteAdminByPK' => 'users#delete_admin'


  #=========== CITIES ===============
  post 'getCities'  => 'cities#index'


  #=========== EVENTS ===============
  post 'getEventByCityAndCharacter' => 'events#get_events'
  post 'getEventByCityAndCharacterWithDate' => 'events#get_events_date'
  post 'getEventByCityAndCharacterGuest' => 'events#get_events_guest'
  post 'getEventByCityAndCharacterWithDateGuest' => 'events#get_events_date_guest'
  post 'getEventsByDateWithCountAndTag' => 'events#getEventsByDateWithCountAndTag' #!
  post 'getEventsByMounthWithCountAndTag' => 'events#getEventsByMounthWithCountAndTag'
  post 'getEventsByTagWithCount' => 'events#getEventsByTagWithCount'


  #========== FAVORITIES EVENT ======
  post 'getFavoriteEvents' => 'favorities#index', :as => :getFavotityEvents
  post 'addFavoriteEvent' => 'favorities#create' # only event_id
  post 'deleteFavoriteEvent' => 'favorities#destroy' #id


  #========= DALY POST ==============
  post 'getDailyPost' => 'daily_posts#show'
  post 'getDailyPostGuest' => 'daily_posts#show_guest'
  post 'setDailyPost' => 'daily_posts#update'


  #======== ERROR SERVER ===========
  get '*unmatched_route', :to => 'application#not_found_404'
  post '*unmatched_route', :to => 'application#not_found_404'

end
