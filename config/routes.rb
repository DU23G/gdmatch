Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]

  get "toppages/index" => "toppages#index"
  root "toppages#index"

  # get 'tweets' => 'tweets#index'
  # post 'tweets' => 'tweets#create'

  # get 'tweets/:id' => 'tweets#show',as: 'tweet'
  # patch 'tweets/:id' => 'tweets#update'
  # delete 'tweets/:id' => 'tweets#destroy'
  # get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'

  # 以下、書かれていなかったルーティング
  # get    'tweets/new'      => 'tweets#new'
  # put    'tweets/:id'      => 'tweets#update'
   post "tweets/:id" => 'tweets#show'

  resources :tweets do
    member do
      post 'take'
      post 'cancel'
      # get 'take'
      # get 'cancel'
    end
    resources :likes, only: [:create, :destroy,]
    resources :remarks, only: [:create]
  end
  
  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:create]

end
