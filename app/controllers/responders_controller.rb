class RespondersController < ApplicationController
  def index
    if params[:show] == 'capacity'
      respond_with responder_capacity
    else
      respond_with responders
    end
  end

  def show
    respond_with responder
  end

  def create
    respond_with responders.create(responder_create_params)
  end

  def update
    responder.update(responder_update_params)
    respond_with responder
  end

  private

  def permitted_create_params
    [:type, :name, :capacity]
  end

  def permitted_update_params
    [:on_duty]
  end

  def responders
    Responder.all
  end

  def responder
    responders.find_by(name: params[:id])
  end

  def responder_create_params
    params.require(:responder).permit(permitted_create_params)
  end

  def responder_update_params
    params.require(:responder).permit(permitted_update_params)
  end

  def responder_capacity
    { capacity: ResponderCapacity.new }
  end
end
