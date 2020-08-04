Rails.application.routes.draw do
  root 'static_pages#Home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/loguot', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  scope '(:locale)', locale: /en|vi/ do
    resources :users
    resources :authors
    resources :reviews
    resources :requests
    get "/my_cart/:id", to: "carts#my_cart"
    resources :carts do
      member do
        # get "confirm"
        post 'confirm'
        get 'accept'
        get 'decline'
        get 'detail'
      end
    end
    resources :books do
      resources :reviews
    end
  end
end
