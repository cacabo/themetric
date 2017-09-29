Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  resources :articles

  patch 'articles/:id/publish', to: 'articles#publish', as: 'publish'
  patch 'articles/:id/unpublish', to: 'articles#unpublish', as: 'unpublish'
  patch 'articles/:id/feature', to: 'articles#feature', as: 'feature'
  patch 'articles/:id/unfeature', to: 'articles#unfeature', as: 'unfeature'

  patch 'admins/:id/super', to: 'admins#super', as: 'super'
  patch 'admins/:id/unsuper', to: 'admins#unsuper', as: 'unsuper'

  resources :contacts, only: [:new, :create]

  root 'welcome#index'

  get 'about', to: 'welcome#about', as: 'about'

  get 'articles/tags/:tag', to: 'articles#index', as: 'tag'
  get 'articles/region/:region', to: 'articles#index', as: 'region'

  get 'admins/info', to: 'admins#info', as: 'info'

  resources :emails, only: [:index, :create, :destroy]

  resources :referrals, only: [:create, :index, :destroy]

  resources :admins, only: [:show, :edit, :update]

  # Handle 404
  get '404', to: 'welcome#notfound', as: 'notfound'
  get '*unmatched_route', to: 'welcome#notfound'
end
