Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create, :index, :edit, :destroy, :update] do
    get 'profile', on: :member
  end
  
  #get 'users/:username', to: 'users#index', as: 'user'
  #get 'users/new', to: 'users#new', as: 'new'
  #post 'users/create', to: 'users#create', as: 'create'
  root "users#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
