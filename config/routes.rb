Rails.application.routes.draw do
  # admin-specific routes
  devise_for :admins, controllers: { sessions: 'admins/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  # general routes for articles
  resources :articles

  # handle 404
  get 'notfound', to: 'welcome#notfound', as: 'notfound'

  # specific article routes
  patch 'articles/:id/publish', to: 'articles#publish', as: 'publish'
  patch 'articles/:id/unpublish', to: 'articles#unpublish', as: 'unpublish'
  patch 'articles/:id/feature', to: 'articles#feature', as: 'feature'
  patch 'articles/:id/unfeature', to: 'articles#unfeature', as: 'unfeature'

  # querrying for specific articles
  get 'articles/tags/:tag', to: 'articles#index', as: 'tag'
  get 'articles/region/:region', to: 'articles#index', as: 'region'
  get 'articles/topic/:topic', to: 'articles#index', as: 'topic'

  # admin routes
  patch 'admins/:id/super', to: 'admins#super', as: 'super'
  patch 'admins/:id/unsuper', to: 'admins#unsuper', as: 'unsuper'
  patch 'admins/:id/guest', to: 'admins#guest', as: 'guest'
  patch 'admins/:id/unguest', to: 'admins#unguest', as: 'unguest'

  resources :contacts, only: [:new, :create]

  # homepage
  root 'welcome#index'

  # about page
  get 'about', to: 'welcome#about', as: 'about'

  # admin information
  get 'admins/info', to: 'admins#info', as: 'info'
  get 'admins', to: 'admins#index', as: 'admins'

  # managing the email list
  resources :emails, only: [:index, :create, :destroy]

  # managing who can create accounts
  resources :referrals, only: [:create, :index, :destroy]

  # managing editing, showing, and updating admin information
  resources :admins, only: [:show, :edit, :update, :destroy]

  # Handle 404
  get '*unmatched_route', to: 'welcome#notfound'
end
