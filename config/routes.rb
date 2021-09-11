Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, :only => [:index, :show]
  # root "users#index"

  get "toppages/index" => "toppages#index"
  root "toppages#index"

  # 以下、書かれていなかったルーティング
  # put    'tweets/:id'      => 'tweets#update'

  get    'tweets/new'      => 'tweets#new'
  post "tweets/:id" => 'tweets#show'

  resources :tweets do
    member do
      post 'take'       # get 'take'
      post 'cancel'       # get 'cancel'
    end
    resources :likes, only: [:create, :destroy,]
    resources :remarks, only: [:create]
  end
  
  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end

  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

end
