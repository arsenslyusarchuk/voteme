require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', sessions: 'sessions' }

  mount Sidekiq::Web, at: '/xmt27nlb'

  namespace :api do
    namespace :v1 do
      resources :polls do
        collection do
          get 'search'
        end
        member do
          get 'stop'
        end
      end
    end
  end
  root 'home#index'
  get '*path' => "home#index"
end
