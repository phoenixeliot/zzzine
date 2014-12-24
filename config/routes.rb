Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :tweets, only: [:index, :show]
  resources :view, only: [:show]
 	
 	match 'dashboard' => 'tweets#index', :via => [:get],  :as => 'user_root'

	devise_scope :user do
	  root to: "devise/sessions#new"
	end
end
