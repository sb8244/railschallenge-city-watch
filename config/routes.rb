Rails.application.routes.draw do
  resources :emergencies, defaults: { format: :json }
  resources :responders, defaults: { format: :json }

  match '/404' => 'application#not_found', via: :all
end
