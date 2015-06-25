Rails.application.routes.draw do

  devise_for :users,  controllers: { registrations: "registrations" },
                      controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resource :bleacher_report, only: [:new, :create]
  resources :tweets
  get "/auth/:provider/callback" => "twitter_oauth#create", as: :twitter_oauth_path
  # get '/sign-in' => 'bleacher_report#new'
  # post '/sign-in' => 'bleacher_report#create'
  # get "/signout" => "sessions#destroy", :as => :signout


  # require 'sidekiq/web'
  # # ...
  # mount Sidekiq::Web, at: '/sidekiq'
  root 'welcome#index'

end
