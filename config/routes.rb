Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # resources :users, :only => [:index, :show]
  resources :users, only: [:index, :show, :edit, :update, :ff] do
      resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'users/:id/ff' => 'users#ff'
  get 'users/:id/likedtweets' => 'users#likedtweets'
  get 'users/:id/postedtweets' => 'users#postedtweets'
  get 'users/:id/takedtweets' => 'users#takedtweets'

  # root "users#index"

  #ログイン後の遷移先をtweets#indexに変更
  # get "toppages/index" => "toppages#index"
  # root "toppages#index"

    get "tweets/index" => "tweets#index"
    root "tweets#index"

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
    resources :grouptalks, only: [:create]
  end

  get    'tweets/:id/groupchat'      => 'tweets#groupchat'
  get    'tweets/:id/likes'      => 'tweets#likes'
  
  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end

  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'

end
