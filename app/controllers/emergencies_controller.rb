class EmergenciesController < ApplicationController
  def index
    respond_with emergencies, full_responses: full_response_metrics, meta_key: :full_responses
  end

  def show
    respond_with emergency
  end

  def create
    emergencies.create(create_params).tap do |emergency|
      EmergencyDispatch.new(emergency).call if emergency.persisted?
      respond_with emergency
    end
  end

  def update
    emergency.update(update_params)
    emergency.responders.clear if emergency.resolved_at
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
    @emergency ||= emergencies.find_by(code: params[:id])
  end

  def update_params
    @update_params ||= super.tap do |p|
      p[:full_response] = emergency.full_response? if p[:resolved_at].present?
    end
  end

  def full_response_metrics
    @full_response_metrics ||= [Emergency.full_response_count, Emergency.count]
  end
end
