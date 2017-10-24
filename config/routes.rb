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
  get 'comparison/fortress_1782', to: 'comparison#fortress_1782'
  get 'comparison/city_1943', to: 'comparison#city_1943'
  get 'comparison/fortress_on_2017', to: 'comparison#fortress_on_2017'
  get 'maps/1782', to: 'maps#map_1782'
end
