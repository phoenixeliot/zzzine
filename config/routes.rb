Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", sessions: "custom/sessions"  }
  resources :tweets, only: [:index, :show]
  resources :view, only: [:show]
 	
 	match 'new' => 'tweets#index', :via => [:get],  :as => 'user_root'

	devise_scope :user do
	  root to: "custom/sessions#new"
	end
end
