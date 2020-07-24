Rails.application.routes.draw do
  root "static_pages#Home"

  get "/login",to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/loguot", to:"sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"

  scope "(:locale)", locale: /en|vi/ do
    resources :users
    resources :books
    resources :authors
  end
end
