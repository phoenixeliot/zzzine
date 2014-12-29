Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", sessions: "custom/sessions"  }
  resources :tweets, only: [:index, :show]
  resources :view, only: [:show, :edit]
  
  match 'terms' => 'pages#terms', :via => [:get]

 	match 'new' => 'tweets#index', :via => [:get],  :as => 'user_root'

	devise_scope :user do
	  root to: "custom/sessions#new"
	  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
	end

	match "*path" => redirect("/"), :via => [:get]
end
