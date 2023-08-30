# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pull_requests/index'
  get 'pull_requests/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
