Rails.application.routes.draw do
  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get '/about' => 'welcome#about'
  root 'welcome#index'

  resources :projects do
    resources :comments, only: [:create]
  end
  resources :people
end
