Rails.application.routes.draw do
  get 'home/index'
  get 'home/show', to: 'home#show', as: :about

  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out

  get '/account', to: 'users#show', as: :account
  get '/chathistory', to: 'conversations#show', as: :chat_history

  get '/admin', to: 'admin#show', as: :admin
  post '/admin', to: 'admin#lock_user', as: :lock_user
  get '/admin/user', to: 'admin#view_user', as: :view_user
  get '/admin/user/convos', to: 'admin#view_user_convos', as: :view_user_convos

  get '/history', to: 'messages#show'
  get '/chat', to: 'beardbot#chat'

  post '/msg', to: 'messages#create'

  resources :users, only: [:new, :create, :update]
  resources :user_sessions, only: [:create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :conversations do
    resources :messages
  end

  root 'home#index'
end
