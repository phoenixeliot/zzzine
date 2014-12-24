Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :tweets, only: [:index]
  resources :views, only: [:show]
  root 'tweets#index'
end
