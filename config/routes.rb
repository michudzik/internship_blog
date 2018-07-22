Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'

  #get '/authors',       to: 'authors#index',  as: :authors
  #get '/authors/:id',   to: 'authors#show',   as: :author
  #get '/author/new',    to: 'authors#new',    as: :new_author
  resources :authors
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :commentators, only: [:index, :new, :create, :destroy]
end
