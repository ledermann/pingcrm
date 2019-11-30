Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
