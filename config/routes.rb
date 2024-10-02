Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create, :index, :edit, :destroy, :update] do
    get 'profile', on: :member
  end
  root "users#index"
end
