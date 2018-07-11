Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'

  get '/authors',       to: 'authors#index',  as: :authors
  get '/authors/:id',   to: 'authors#show',   as: :author
end
