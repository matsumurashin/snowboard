Rails.application.routes.draw do


  namespace :admin do
    get 'genres' => 'genre#index'
    post 'genres' => 'genre#create'
    get 'genre/:id' => 'genre#edit',as: :'genre/edit'
    patch 'genre/:id' => 'genre#update',as: :'genre'
    # get 'sign_in' => 'sessions#new'
    get '' => 'homes#top'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do
    get 'orders/confirm' => 'orders#confirm'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]

   resources :shipping_address, only: [:index,:create,:edit,:update,:destroy]

    resources :cart_items, only: [:index, :update, :create]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    delete 'cart_items/:id' => 'cart_items#destroy'

    get 'customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch 'customers/infomation' => 'customers#update'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdraw' => 'customers#withdraw'

    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :items, only: [:index, :show] do
      resources :comments, only: [:create, :destroy]
    end

  end

  devise_for :customers, skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:password], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end

