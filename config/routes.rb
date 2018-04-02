Rails.application.routes.draw do
  root to: 'pages#index'

  defaults format: :json do
    # Rooms
    resources :rooms, only: %i[index show create], param: :key do
      # Danmus
      resources :danmus, only: %i[create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
