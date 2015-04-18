class NotNewId
  def self.matches?(request)
    request.path_parameters[:id] != "new"
  end
end

Rails.application.routes.draw do

  resources :emergencies, only: [:index, :create, :show, :update], defaults: { format: :json }, constraints: NotNewId
  resources :responders, only: [:index, :create, :show, :update], defaults: { format: :json }, constraints: NotNewId

  match '/404' => 'errors#not_found', via: :all
end
