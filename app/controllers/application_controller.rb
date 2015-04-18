class ApplicationController < ActionController::Base
  respond_to :json

  before_filter :reject_unpermitted_create_params, only: [:create]
  before_filter :reject_unpermitted_update_params, only: [:update]

  protected

  def permitted_create_params
    []
  end

  def permitted_update_params
    []
  end

  private

  def reject_unpermitted_create_params
    bad_keys = params[:responder].keys.reject{ |key| permitted_create_params.include?(key.to_sym) }
    return if bad_keys.empty?

    render json: { message: "found unpermitted parameter: #{bad_keys.first}" }, status: :unprocessable_entity
  end

  def reject_unpermitted_update_params
    bad_keys = params[:responder].keys.reject{ |key| permitted_update_params.include?(key.to_sym) }
    return if bad_keys.empty?

    render json: { message: "found unpermitted parameter: #{bad_keys.first}" }, status: :unprocessable_entity
  end
end
