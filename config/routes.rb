Rails.application.routes.draw do
  get "notifications/edit"
  get "notifications/update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "page#index"

  get "docs/api", to: "page#api_docs", as: :api_docs
  get "confirm_logout", to: "page#confirm_logout", as: :confirm_logout

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :apps do
    member do
      put "regenerate_api_key"
    end
  end

  resources :settings, only: [ :index ] do
    collection do
      patch "", to: "settings#update"
    end
  end

  resources :users do
    collection do
      get "me", to: "users#me"
      patch "me", to: "users#update_me"
    end
  end

  resources :messages, only: [ :show, :index ]

  resources :notifications, only: [ :edit, :update, :new, :create, :destroy ] do 
    member do
      get "confirm_delete"
    end
  end

  # External API
  put "api/v1/message", to: "external_api#add_message_v1"
end
