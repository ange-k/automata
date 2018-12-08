Rails.application.routes.draw do
  # Omniauth以外の機能を停止
  devise_for :social_accounts, skip: [:sign_up, :sign_in, :sign_out, :registrations, :sessions, :passwords, :confirmations, :unlock],
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # こっちは単数形
  devise_scope :social_account do
    get    '/social_accounts/sign_in', to: 'devise/sessions#new', as: :new_social_account_session
    post    '/social_accounts/sign_in', to: 'devise/sessions#new', as: :social_account_session
    delete '/social_accounts/sign_out', to: 'devise/sessions#destroy', as: :destroy_social_account_session
  end
  root to: 'toppages#index'
  get '/toppages/select', to: 'toppages#select'
  post '/toppages/category', to: 'toppages#category'
end
