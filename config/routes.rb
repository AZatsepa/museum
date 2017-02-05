Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'   
  end

  resources :posts do
    resources :comments
  end  

  get 'results', to: 'results#index', as: 'results'
  get 'users/show', as: 'user_root'
  
  get 'about', to: "pages#about", as: "about"
  root 'pages#index'
end
