Rails.application.routes.draw do

  namespace :admin do
    resources :admins, :except => [:show]
    get '' => 'admins#index'
    get 'cities' => 'cities#index'
    get 'cities/new' => 'cities#new', as: :city_new
    post 'cities/new' => 'cities#create'
    get 'login' =>  'sessions#new', as: :login
    post 'login' => 'sessions#create'
    get 'logout' => 'sessions#destroy', as: :logout
    get 'users' => 'users#index'
    get 'users/:id/edit' => 'users#edit'
    get 'users/:id' => 'users#show'
    get 'characters' => 'characters#index'
    get 'events' => 'events#index'
    get 'events/new' => 'events#new'
    delete 'admins/:id' => 'admins#destroy'
    delete 'admin/users/:id' => 'users#destroy'

  end

  resources :characters, :except=>[:index, :show, :delete]
  post 'characters' => 'characters#index'

  resources :users, :except => [:destroy, :update]

  patch 'users/:id' => 'admin/users#update'
  patch 'users_edit/:id' => 'users#update'

  get 'events/new' => 'admin/events#new', as: :events
  post 'events/new' => 'admin/events#create'
  resources :tags

  resources :comments, :except => [:update, :edit, :show]


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


  #======== ERROR SERVER ===========
  # get '*unmatched_route', :to => 'application#not_found_404'
  # post '*unmatched_route', :to => 'application#not_found_404'

end
