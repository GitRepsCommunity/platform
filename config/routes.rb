# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :github_explorer do
    resources :api_requests, only: %i[index show new create destroy]
  end
  resources :profiles
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'profiles#index'
  # TODO: Add HomeController for root index:
  # root "home#index"
end
