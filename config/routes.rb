require 'api_constraints'

Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  scope module: :api, defaults: { format: :json }  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1) do
      # We are going to list our resources here
      resources :users, only: [:index, :show]
      resources :courses, only: [:index, :show] do
        resources :comments, only: [:index, :show, :create, :update]
        resources :ratings, only: [:index, :show]
      end
    end
  end
end
