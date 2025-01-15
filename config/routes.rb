Rails.application.routes.draw do
  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favourites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :users
  get "signup" => "users#new"
end
