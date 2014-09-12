Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :projects
  resources :people
  resources :events
end
