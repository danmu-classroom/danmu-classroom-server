Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users
  resources :rooms, only: %i[index] do
    resources :danmus, only: %i[index]
  end

  namespace :api, defaults: { format: 'json' } do
    resources :rooms, only: %i[index show create update], param: :key do
      resources :danmus, only: %i[index create]
    end
    post 'line/callback' # Line bot webhook
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
