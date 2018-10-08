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

  get '/donate', to: redirect('https://secure.codeforamerica.org/page/contribute/donate-to-a-brigade-today?source_codes=codeforatlanta-redirect&brigade=Code%20for%20Atlanta')
  get '/data', to: redirect('https://docs.google.com/document/d/122GLuyEnhQbAFbOMGqnj4nSAD2OW13DpkAxsxsGJTsA/edit')
  get '/greenspace', to: redirect('https://docs.google.com/document/d/1t1ajdjHXcz4zI4joHMbgGSN8nCgvnPpyfPF2t2ZXp6g/edit?usp=sharing')
  get '/spark', to: redirect('https://goo.gl/forms/bUQQW4zzD85GWQAf1')
end
