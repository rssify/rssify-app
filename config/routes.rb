Rails.application.routes.draw do
  root 'welcome#index'

  resources :feeds, only: [:show, :create]
end
