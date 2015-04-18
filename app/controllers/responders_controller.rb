class RespondersController < ApplicationController
  respond_to :json

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

  def responders
    Responder.all
  end

  def responder
    responders.find(params[:id])
  end

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
