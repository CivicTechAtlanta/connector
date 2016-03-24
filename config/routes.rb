Rails.application.routes.draw do
  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get '/about' => 'welcome#about'
  get '/conduct' => 'welcome#conduct', :as => :conduct
  root 'welcome#index'

  resources :projects do
    member do
      get :contribute
      get :uncontribute
    end

    resources :comments, only: [:create]
  end
  resources :people

  get '/donate', to: redirect('https://secure.codeforamerica.org/page/contribute/default?brigade=Code%20for%20Atlanta')
end
