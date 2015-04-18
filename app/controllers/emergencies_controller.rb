class EmergenciesController < ApplicationController
  def show
    respond_with emergency
  end

  def create
    respond_with emergencies.create(create_params)
  end

  private

  def model_name
    :emergency
  end

  def permitted_create_params
    [:code, :fire_severity, :police_severity, :medical_severity]
  end

  def emergencies
    Emergency.all
  end

  def emergency
    emergencies.find_by(id: params[:id])
  end
end
