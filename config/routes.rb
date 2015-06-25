Rails.application.routes.draw do

  devise_for :users,  controllers: { registrations: "registrations",
                                     omniauth_callbacks: "omniauth_callbacks"}
  resources :bleacher_reports, only: [:new, :create]
  resources :tweets
  get "/auth/:provider/callback" => "twitter_oauth#create"
  # get '/sign-in' => 'bleacher_report#new'
  # post '/sign-in' => 'bleacher_report#create'
  # get "/signout" => "sessions#destroy", :as => :signout


  # require 'sidekiq/web'
  # # ...
  # mount Sidekiq::Web, at: '/sidekiq'
  root 'welcome#index'

end
