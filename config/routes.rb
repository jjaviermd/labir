# frozen_string_literal: true

Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/settings'
  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/settings', to: 'pages#settings'

  root 'pages#home'
end
