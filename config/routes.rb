# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tracks#index'
  resources :tracks, except: %i[edit update destroy]
  namespace :api do
    namespace :v1 do
      resources :tracks, only: %i[show index] do
        resources :points, only: %i[index] do
          get :for_map, on: :collection
        end
      end
    end
  end
end
