# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    root 'static_pages#Home'
    get     '/login',           to: 'sessions#new'
    post    '/login',           to: 'sessions#create'
    delete  '/loguot',          to: 'sessions#destroy'
    get     '/signup',          to: 'users#new'
    post    '/signup',          to: 'users#create'
    get     '/my_cart/:id',     to: 'carts#my_cart'
    get     '/admin_authors', to: 'authors#admin'
    resources :users
    resources :authors
    resources :reviews
    resources :requests

    resources :carts do
      member do
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
