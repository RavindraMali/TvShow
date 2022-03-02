require 'sidekiq/web'
require 'sidekiq/cron/web'


Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources:shows do
    member do
        post :add_to_favorites
        delete :remove_from_favorites
    end
  end
  get "/favorites", to: "shows#favorites_index", as: "favorites"
end
