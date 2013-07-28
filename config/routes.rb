Aszist::Application.routes.draw do

  devise_for :users

  resources :tickets do
    resources :comments
  end

  resources :users do
    collection do
      post 'manage'
    end
  end

  root :to => 'pages#index'

 end
