Rails.application.routes.draw do
  
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
      member do
        get :likes
      end
    end
  end

  namespace :admin do
    get ""=>"homes#top"
  end

end
