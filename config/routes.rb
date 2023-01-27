Rails.application.routes.draw do

  
  resources :books, only: [:edit, :update, :index, :show, :create, :destroy]
  get 'home/about'=>'homes#about'
  devise_for :users
  root to:"homes#top"
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
