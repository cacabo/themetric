Rails.application.routes.draw do
  devise_for :admins

  resources :articles do
    resources :comments
  end

  resources :contacts, only: [:new, :create]

  root 'welcome#index'

  get 'about', to: 'welcome#about', as: 'about'
  get 'articles/tags/:tag', to: 'articles#index', as: 'tag'
end
