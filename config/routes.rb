Rails.application.routes.draw do
  resources :emergencies, defaults: { format: :json }
  resources :responders, defaults: { format: :json }

  match '/404' => 'errors#not_found', via: :all
end
