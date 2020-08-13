Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  # get 'pages/index'
  
  root 'pages#index'

  get 'pages/show'

  get 'apis/index'
  
  get 'apis/serch'
  post 'apis/serch'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'
end
