# frozen_string_literal: true

Rails.application.routes.draw do
  mount Tailwind::Scaffold::Engine => '/tailwind-scaffold'

  resources :authors
end
