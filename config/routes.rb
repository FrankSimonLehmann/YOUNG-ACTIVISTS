Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :demonstrations, only: [:create, :new, :edit, :update, :destroy]
  resources :demonstrations, only: [:index, :show] do
    resources :bookmarks, only: [:new, :create]
    get "joined", to: "bookmarks#joined"
  end
  resources :bookmarks, only: [:destroy]
  # resources :demonstrations, only: [:show]


  resources :users, :only =>[:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "home", to: "pages#home"
  get "profile", to: "pages#profile"
  get "bookmarked", to: "pages#bookmarked"
  get "mydemonstrations", to: "pages#mydemonstrations"

  # Defines the root path route ("/")
  # root "posts#index"
end
