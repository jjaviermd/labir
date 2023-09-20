# frozen_string_literal: true

Rails.application.routes.draw do

  resources :patients, :cases, except: :destroy
  resources :pathologists
  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/settings', to: 'pages#settings'

  root 'pages#home'
end
