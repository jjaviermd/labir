# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :pathologists, controllers: {
    sessions: "pathologists/sessions",
    registrations: "pathologists"
  }
  resources :pathologists
  devise_for :laboratories, controllers: {
    sessions: "laboratories/sessions",
    registrations: "laboratories/registrations"
  }
  resources :patients, except: :destroy
  resources :cases, except: :destroy do
    get "sign_inform", on: :member
    get "send_report", on: :member
  end
  get "/pathologists/:id/pending", to: "pathologists#pending", as: "pending"
  get "/pathologists/:id/finished", to: "pathologists#finished", as: "finished"
  get "/home", to: "pages#home"
  get "/about", to: "pages#about"
  get "/settings", to: "pages#settings"
  resources :templates, except: [:update, :create]
  resources :macro_templates, only: [:index, :update, :create]
  resources :micro_templates, only: [:index, :update, :create]
  resources :diagnosis_templates, only: [:index, :update, :create]

  root "pages#welcome"
end
