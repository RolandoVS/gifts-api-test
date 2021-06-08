Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      resources :schools, only: [:index, :create, :update, :destroy] do
        resources :orders, only: [:index, :create, :update, :destroy] do
          put "ship", to: "orders#ship"
          put "cancel", to: "orders#cancel"
        end
        resources :recipients, only: [:index, :create, :update]
      end
    end
  end
end
