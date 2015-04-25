class ApplicationController < ActionController::Base
  respond_to :json

  # Handle rejecting parameters not in the whitelist defined by a controller
  before_action :reject_unpermitted_create_params, only: [:create]
  before_action :reject_unpermitted_update_params, only: [:update]

  protected

  def permitted_create_params
    []
  end

  def permitted_update_params
    []
  end

  # The model name for a controller is the singularized form of the controller name
  # EmergenciesController is emergency, etc
  def model_name
    self.class.name.underscore.split('_').first.singularize
  end

  def create_params
    params.require(model_name).permit(permitted_create_params)
  end

  def update_params
    params.require(model_name).permit(permitted_update_params)
  end

  private

  def reject_unpermitted_create_params
    bad_keys = params[model_name].keys.reject { |key| permitted_create_params.include?(key.to_sym) }
    return if bad_keys.empty?

    render json: { message: "found unpermitted parameter: #{bad_keys.first}" }, status: :unprocessable_entity
  end

  def reject_unpermitted_update_params
    bad_keys = params[model_name].keys.reject { |key| permitted_update_params.include?(key.to_sym) }
    return if bad_keys.empty?

    render json: { message: "found unpermitted parameter: #{bad_keys.first}" }, status: :unprocessable_entity
  end
end
