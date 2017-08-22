Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  resources :articles

  resources :contacts, only: [:new, :create]

  root 'welcome#index'

  get 'about', to: 'welcome#about', as: 'about'
  get 'articles/tags/:tag', to: 'articles#index', as: 'tag'

  resources :admins, only: [:index, :show, :edit, :update]

  # Handle 404
  get '*unmatched_route', to: 'welcome#notfound'
end
