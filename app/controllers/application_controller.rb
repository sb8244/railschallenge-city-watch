class ApplicationController < ActionController::Base
  respond_to :json

  before_filter :reject_unpermitted_params, only: [:create]

  protected

  def permitted_params
    []
  end

  def reject_unpermitted_params
    bad_keys = params[:responder].keys.reject{ |key| permitted_params.include?(key.to_sym) }
    return if bad_keys.empty?

    render json: { message: "found unpermitted parameter: #{bad_keys.first}" }, status: :unprocessable_entity
  end
end
