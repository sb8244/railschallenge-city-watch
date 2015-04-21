class ErrorsController < ApplicationController
  def not_found
    render json: { message: 'page not found' }, status: :not_found
  end
end
