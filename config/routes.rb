Rails.application.routes.draw do
  
  namespace :user do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  get "search" => "searches#search"
  
  scope module: :user do
    root :to =>"homes#top"
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :likes
      end
    end
  end

  namespace :admin do
    get ""=>"homes#top"
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

end
