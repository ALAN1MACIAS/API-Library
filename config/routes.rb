Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :book, only: %I[index create destroy]

      post 'authenticate', to: 'authentication#create'
    end
  end
end
