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
    respond_with responders.create(create_params)
  end

  def update
    responder.update(update_params)
    respond_with responder
  end

  private

  def permitted_create_params
    @permitted_create_params ||= [:type, :name, :capacity]
  end

  def permitted_update_params
    @permitted_update_params ||= [:on_duty]
  end

  def model_name
    :responder
  end

  def responders
    Responder.all
  end

  def responder
    @responder ||= responders.find_by(name: params[:id])
  end

  def responder_capacity
    @responder_capacity ||= { capacity: ResponderCapacity.new }
  end
end
