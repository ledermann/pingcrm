Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, skip: %i[sessions passwords registrations]
  as :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    match 'logout',
          to: 'users/sessions#destroy',
          as: :destroy_user_session,
          via: Devise.mappings[:user].sign_out_via
  end

  resources :reports, only: [:index]
  resources :users, except: [:show] do
    member { put 'restore' }
  end
  resources :organizations, except: %i[show new] do
    member { put 'restore' }
  end
  resources :contacts, except: [:show] do
    member { put 'restore' }
  end

  root 'dashboard#index'
end
