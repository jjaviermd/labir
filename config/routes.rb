# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :laboratories, controllers: {
    sessions: "laboratories/sessions",
    registrations: "laboratories/registrations"
  }
  resources :patients, except: :destroy
  resources :cases, except: :destroy do
    get "sign_inform", on: :member
  end
  resources :pathologists
  get "/pathologists/:id/pending", to: "pathologists#pending", as: "pending"
  get "/pathologists/:id/finished", to: "pathologists#finished", as: "finished"
  get "/home", to: "pages#home"
  get "/about", to: "pages#about"
  get "/settings", to: "pages#settings"
  resources :templates, only: [:index, :show, :edit, :new, :destroy]
  resources :macro_templates, except: [:index, :edit, :new, :show, :destroy]
  resources :micro_templates, except: [:index, :edit, :new, :show, :destroy]
  resources :diagnosis_templates, except: [:index, :edit, :new, :show, :destroy]

  root "pages#home"
end
