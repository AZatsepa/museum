Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    confirmations: 'users/confirmations' }
  root 'pages#main'
  #
  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  #
  resources :posts, only: %i[index show] do
    resources :comments
  end
  resources :users

  # get 'results', to: 'results#index', as: 'results'
  # get 'users/show', as: 'user_root'
  # get 'about', to: 'pages#about', as: 'about'
  get 'comparison/1782_1943', to: 'comparison#_1782_1943'
  get 'comparison/1943_2017', to: 'comparison#_1943_2017'
  get 'comparison', to: 'comparison#index'
  get 'comparison/1782_2017', to: 'comparison#_1782_2017'
  get 'maps/1782', to: 'maps#map_1782'
  namespace :admin do
    post 'markdown/preview'
    resources :posts do
      resources :comments
    end
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get 'me', to: 'profiles#me'
        get 'other_users', to: 'profiles#other_users'
      end
    end
  end

  mount ActionCable.server => '/cable'
end
