Rails.application.routes.draw do
  root to: 'pages#index'
  # Room
  resources :rooms, except: [:new, :edit, :update], defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
