Rails.application.routes.draw do
  root 'welcome#index'

  resources :feeds, only: :index
end
