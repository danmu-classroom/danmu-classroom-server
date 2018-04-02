Rails.application.routes.draw do
  root to: 'pages#index'
  # Room
  resources :rooms, only: %i[index show create], param: :key do
    resources :danmus, only: %i[create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
