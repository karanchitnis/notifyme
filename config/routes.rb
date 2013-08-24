SampleApp::Application.routes.draw do

  get "trials/show"

  resources :playlists do
    collection { post :sort }
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions
  resources :subscriptions, only: [:create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :static_pages
  resources :trials, :only => [:index]

  root to: 'static_pages#home'

  get "search/index"

  match '/signup',   to: 'users#new'
  match '/signin',   to: 'sessions#new'
  match '/signout',  to: 'sessions#destroy', via: :delete

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match "/auth/:provider/callback" => "sessions#createomni"
  match "/signoutomni" => "sessions#destroyomni", as: :signoutomni

  post '/ajax/embed_link', to: 'links#embed'
  post '/ajax/results', to: 'recommendations#results'

  match '/del_sub:id', to: 'static_pages#del_sub', :as => :del_sub
  match '/feed_view:id', to: 'static_pages#feed_view', :as => :feed_view
  
  end