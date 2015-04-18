Rails.application.routes.draw do
  resources :emergencies, only: [:index, :create, :show, :update], defaults: { format: :json }
  resources :responders, only: [:index, :create, :show, :update], defaults: { format: :json }
end
