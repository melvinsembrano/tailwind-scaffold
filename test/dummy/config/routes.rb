# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books
  mount Tailwind::Scaffold::Engine => '/tailwind-scaffold'

  resources :authors
end
