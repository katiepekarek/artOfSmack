Rails.application.routes.draw do

  root 'bleacher_report#new'
  get '/sign-in' => 'bleacher_report#new', as: :signin
  post '/sign-in' => 'bleacher_report#create'
  get "/auth/:provider/callback" => "twitter_oauth#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :welcome
  resources :tweets

end
