Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#front'
  get 'pages/front'
  get '/user/:user', to: 'pages#user', as: 'user'

end
