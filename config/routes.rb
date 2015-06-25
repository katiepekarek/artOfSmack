Rails.application.routes.draw do

  devise_for :users,  controllers: { registrations: "registrations" },
                      controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'welcome#index'
  get '/sign-in' => 'bleacher_report#new', as: :signin
  post '/sign-in' => 'bleacher_report#create'
  get "/auth/:provider/callback" => "twitter_oauth#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :tweets

  require 'sidekiq/web'
  # ...
  mount Sidekiq::Web, at: '/sidekiq'

end
