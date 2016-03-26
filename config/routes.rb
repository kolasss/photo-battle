Rails.application.routes.draw do
  root 'home#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, except: [:new, :edit]
      resources :targets, except: [:new, :edit, :show]
      resources :battles, only: [:show, :create] do
        # member do
        #   get :rounds
        # end
      end
      resources :rounds, only: [:show] do
        resources :photos, only: [:create]
      end
    end
  end
end
