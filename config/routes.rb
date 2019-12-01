Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, skip: [ :sessions, :passwords, :registrations ]
  as :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    match 'logout', to: 'users/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end

  resources :reports, only: [:index]
  resources :organizations, except: [ :show ] do
    member do
      put 'restore'
    end
  end
  resources :contacts, except: [ :show ] do
    member do
      put 'restore'
    end
  end

  get '/error-500' => 'errors#server_error'
  get '/error-404' => 'errors#not_found'

  root 'dashboard#index'
end
