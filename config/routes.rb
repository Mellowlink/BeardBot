Rails.application.routes.draw do
  get 'home/index'

  resources :users, only: [:new, :create, :update]
  resources :user_sessions, only: [:create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :conversations do
    resources :messages
  end

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in

  get '/account', to: 'users#show', as: :account

  get '/chat', to: 'beardbot#chat'

  post '/msg', to: 'messages#create'

  root 'home#index'
end
