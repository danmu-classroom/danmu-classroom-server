Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'pages#index'

  defaults format: :json do
    # Rooms
    resources :rooms, only: %i[index show create update], param: :key do
      # Danmus
      resources :danmus, only: %i[create]
    end
    # Line bot webhook
    post 'line/callback'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
