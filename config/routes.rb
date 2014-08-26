Rails.application.routes.draw do
  root 'welcome#index'

  resources :projects
  resources :people
  resources :organizations
  resources :events
end
