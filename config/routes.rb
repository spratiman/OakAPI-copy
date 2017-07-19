require 'api_constraints'

Rails.application.routes.draw do

  use_doorkeeper
  
  scope module: :api, defaults: { format: :json }  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do

      devise_for :users, :controllers => {sessions: 'api/v1/sessions', registrations: 'api/v1/registrations'}

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
  
  root to: 'root#index'

end
