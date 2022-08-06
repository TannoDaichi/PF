Rails.application.routes.draw do
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :user do
    root :to =>"homes#top"
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  namespace :admin do
    get ""=>"homes#top"
  end

end
