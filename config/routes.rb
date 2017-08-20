Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments
  end

  get 'results', to: 'results#index', as: 'results'
  get 'users/show', as: 'user_root'
  get 'about', to: 'pages#about', as: 'about'
  get 'comparising/1780', to: 'comparising#fortress_1780'
  get 'maps/1782', to: 'maps#map_1782'
end
