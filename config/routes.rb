Rails.application.routes.draw do
  get 'home/index'
  get 'home/show', to: 'home#show', as: :about

  resources :users, only: [:new, :create, :update]
  resources :user_sessions, only: [:create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :conversations do
    resources :messages
  end

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in

  get '/account', to: 'users#show', as: :account
  get '/chathistory', to: 'conversations#show', as: :chat_history

  get '/chat', to: 'beardbot#chat'
  get '/history', to: 'messages#msg_history'

  post '/msg', to: 'messages#create'

  root 'home#index'
end
