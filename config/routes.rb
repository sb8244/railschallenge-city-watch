Rails.application.routes.draw do
  resources :responders, only: [:index, :create, :show], defaults: { format: :json }
end
