require 'api_constraints'

Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  scope module: :api, defaults: { format: :json }  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :users, only: [:index, :show] do
        get 'enrolments', on: :member
      end
      resources :courses, only: [:index, :show], shallow: true do
        resources :comments, only: [:index, :show, :create, :update, :destroy] do
          post 'reply', on: :member
        end
        resources :terms, only: [:index, :show] do
          post 'enrol', on: :member
          delete 'remove_enrol', on: :member
          resources :ratings, only: [:index, :show, :create, :update], shallow: true
        end
      end
    end
  end
end
