Rails.application.routes.draw do
  root to: 'pages#index'
  resources :rooms, except: [:edit, :update], defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
