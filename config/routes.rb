Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  root 'home#index'
  get '/product', to: 'products#new'
  post '/product', to: 'products#create'

  get '/productwebsites/new', to: 'product_websites#new'
  post '/productwebsites/new', to: 'product_websites#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resource :web_scrapes, only: :create

end
