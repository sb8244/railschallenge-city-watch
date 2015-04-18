class RespondersController < ApplicationController
  def index
    respond_with responders
  end

  def show
    respond_with responder
  end

  def create
    respond_with responders.create(responder_params)
  end

  private

  def permitted_params
    [:type, :name, :capacity]
  end

  def responders
    Responder.all
  end

  def responder
    responders.find(params[:id])
  end

  def responder_params
    params.require(:responder).permit(permitted_params)
  end
end
