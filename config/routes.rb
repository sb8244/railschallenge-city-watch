Rails.application.routes.draw do
  resources :responders, only: [:index, :create, :show, :update], defaults: { format: :json }
end
