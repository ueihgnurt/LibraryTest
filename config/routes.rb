Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#Home"
    resources   :users do
      get   "cart",     to: "carts#show"
    end
    resources :books do
      resources :reviews
    end
    resources   :reviews
    resources   :requests
    resources   :authors
    resources   :carts do
      get   "/accept",      to: "carts#accept"
      get   "/decline",     to: "carts#decline"
    end
    get     "/my_cart/:id", to: "reviews#new"
    get     "/my_cart/:id", to: "carts#my_cart"
    get     "/login",       to: "sessions#new"
    post    "/login",       to: "sessions#create"
    delete  "/logout",      to: "sessions#destroy"
    get     "/signup",      to: "users#new"
  end
end
