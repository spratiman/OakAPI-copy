require 'api_constraints'

Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  scope module: :api, defaults: { format: :json }  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :users, only: [:index, :show]
      resources :courses, only: [:index, :show], shallow: true do
        resources :comments, only: [:index, :show, :create, :update, :destroy] do
          post 'reply', on: :member
        end
        resources :ratings, only: [:index, :show, :create, :update]
      end
    end
  end
end
