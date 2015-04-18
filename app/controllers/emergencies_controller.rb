class EmergenciesController < ApplicationController
  def index
    respond_with emergencies
  end

  def show
    respond_with emergency
  end

  def create
    respond_with emergencies.create(create_params)
  end

  def update
    emergency.update(update_params)
    respond_with emergency
  end

  private

  def model_name
    :emergency
  end

  def permitted_create_params
    [:code, :fire_severity, :police_severity, :medical_severity]
  end

  def permitted_update_params
    [:resolved_at, :police_severity, :fire_severity, :medical_severity]
  end

  def emergencies
    Emergency.all
  end

  def emergency
    emergencies.find_by(code: params[:id])
  end
end
