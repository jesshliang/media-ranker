Rails.application.routes.draw do

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'

  get "/users/current", to: 'users#current', as: 'current_user'

  # get 'users/login_form'
  # get 'users/login'
  root to: 'homepages#index'

  resources :works

end
