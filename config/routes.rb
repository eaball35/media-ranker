Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#index"

  resources :works do
    post "/upvote", to: "votes#upvote", as: 'upvote'
    post "/downvote", to: "votes#downvote", as: 'downvote'
  end

  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  post "/users/current", to: "users#current"
  post "/changevote", to: "votes#change_vote", as: 'changevote'

  resources :works
  resources :users
  resources :votes
end
