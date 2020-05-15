# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  root 'pages#main'
  get '/sitemap', to: 'pages#sitemap'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    confirmations: 'users/confirmations',
                                    registrations: 'users/registrations' }

  scope '(/:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get '/feeds', to: 'pages#feeds', format: :rss
    resources :posts, only: %i[index show new create] do
      resources :comments
    end
    resources :users, only: %i[show]
    resources :personalities

    get 'comparison',           to: 'comparison#index'
    get 'comparison/1782_1943', to: 'comparison#_1782_1943'
    get 'comparison/1845_1943', to: 'comparison#_1845_1943'
    get 'comparison/1943_2017', to: 'comparison#_1943_2017'
    get 'comparison/1782_2017', to: 'comparison#_1782_2017'
    get 'comparison/1845_2017', to: 'comparison#_1845_2017'

    resources :maps, only: %i[index] do
      get 'map_1740',            to: 'maps#map_1740',            on: :collection
      get 'map_1752',            to: 'maps#map_1752',            on: :collection
      get 'map_1761',            to: 'maps#map_1761',            on: :collection
      get 'map_1766',            to: 'maps#map_1766',            on: :collection
      get 'map_1768',            to: 'maps#map_1768',            on: :collection
      get 'map_1770',            to: 'maps#map_1770',            on: :collection
      get 'map_1782',            to: 'maps#map_1782',            on: :collection
      get 'map_1786',            to: 'maps#map_1786',            on: :collection
      get 'map_1787_1786',       to: 'maps#map_1787_1786',       on: :collection
      get 'map_1845',            to: 'maps#map_1845',            on: :collection
      get 'map_1910',            to: 'maps#map_1910',            on: :collection
      get 'map_moscovian_crimean_gates', to: 'maps#map_moscovian_crimean_gates', on: :collection
      get 'map_unknown_year',    to: 'maps#map_unknown_year',    on: :collection
      get 'map_unknown_year_2',  to: 'maps#map_unknown_year_2',  on: :collection
      get 'map_unknown_year_3',  to: 'maps#map_unknown_year_3',  on: :collection
    end

    namespace :api do
      namespace :v1 do
        resources :posts, shallow: true, only: %i[index show create] do
          resources :comments, only: %i[index show create]
        end
      end
    end

    get 'search', to: 'search#index'

    mount ActionCable.server => '/cable'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end
