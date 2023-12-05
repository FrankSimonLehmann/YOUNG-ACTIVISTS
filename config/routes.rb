Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :demonstrations, only: [:index, :show] do
    resources :bookmarks, only: [:new, :create]
  end
  resources :bookmarks, only: [:destroy]
  # resources :demonstrations, only: [:show]
  resources :demonstrations, only: [:create, :new]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "home", to: "pages#home"
  get "user", to: "pages#user"

  # Defines the root path route ("/")
  # root "posts#index"
end
