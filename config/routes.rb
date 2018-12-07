Rails.application.routes.draw do
  root to: 'toppages#index'
  get '/toppages/select', to: 'toppages#select'
  post '/toppages/category', to: 'toppages#category'
end
