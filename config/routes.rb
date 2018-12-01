Rails.application.routes.draw do
  root to: 'toppages#index'
  post '/toppages/category', to: 'toppages#category'
end
