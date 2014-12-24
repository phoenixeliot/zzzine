Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :tweets, only: [:index, :show]
  resources :view, only: [:show]
  root 'tweets#index'
end
