# frozen_string_literal: true

Rails.application.routes.draw do
  resources :patients, except: :destroy
  resources :cases, except: :destroy do
    get 'sign_inform', on: :member
  end
  resources :pathologists
  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/settings', to: 'pages#settings'

  root 'pages#home'
end
