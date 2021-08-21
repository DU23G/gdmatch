Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "toppages/index" => "toppages#index"
  root "toppages#index"

  get 'tweets' => 'tweets#index'
  post 'tweets' => 'tweets#create'

end
