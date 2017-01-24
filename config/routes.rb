Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    resources :posts     
  end

  get 'results', to: 'results#index', as: 'results'
  
  root 'posts#index'
end
