Rails.application.routes.draw do
  namespace :api, defaults: { format: :json },
                  constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      resources :products, only: [:show, :create, :update, :destroy]
      resources :orders, only: [:show, :create, :update]
    end
  end
end
