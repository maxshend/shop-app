# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index]
end
