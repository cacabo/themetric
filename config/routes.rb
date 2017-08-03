Rails.application.routes.draw do
  devise_for :admins, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  resources :articles do
    resources :comments
  end

  resources :contacts, only: [:new, :create]

  root 'welcome#index'

  get 'about', to: 'welcome#about', as: 'about'
  get 'articles/tags/:tag', to: 'articles#index', as: 'tag'
  get '*unmatched_route', to: 'welcome#notfound'
end
