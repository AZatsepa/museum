Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    resources :posts do
      resources :comments
    end     
  end

  get 'results', to: 'results#index', as: 'results'
  get 'users/show', as: 'user_root'
  
  root 'pages#index'
end
