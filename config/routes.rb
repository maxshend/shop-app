# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'products#index'

  resources :products, only: %i[index]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :categories, only: %i[index]
      resources :products, only: %i[index] do
        get :statuses, on: :collection
      end
    end
  end
end
