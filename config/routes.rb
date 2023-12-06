Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "articles#index"

  resources :articles, only: [:index, :show]

  namespace :admin do
    root "articles#index"

    resources :articles
    resource :sessions
  end
end
