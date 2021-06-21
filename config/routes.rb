Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/sessions', to: 'sessions#create', as: :session
      resources :users, only: [:create, :show]
      resources :books, only: [:show] do
        post :borrow
        patch :returnal
      end
      resources :loans, only: :index
    end
  end
end
