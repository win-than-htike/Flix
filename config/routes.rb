Rails.application.routes.draw do
  resources :genres
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favourites, only: [:create, :destroy]
  end

  resource :session, only: [ :new, :create, :destroy ]

  resources :users
  get "signup" => "users#new"
end
