Rails.application.routes.draw do

  root to: 'homepages#index'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users, only: [:index, :show]
end
