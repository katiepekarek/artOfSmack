Rails.application.routes.draw do

  root 'welcome#index'
  get '/sign-in' => 'bleacher_report_sessions#new', as: :signin
  post '/sign-in' => 'bleacher_report_sessions#create'
  get "/auth/:provider/callback" => "twitter_oauth#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :tweets

  require 'sidekiq/web'
  # ...
  mount Sidekiq::Web, at: '/sidekiq'

end
