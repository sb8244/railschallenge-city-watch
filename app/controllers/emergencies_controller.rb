class EmergenciesController < ApplicationController
  def index
    respond_with emergencies, full_responses: [ Emergency.full_response_count, Emergency.count ], meta_key: :full_responses
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

    if emergency.resolved_at
      emergency.responders.clear
    end

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

  def update_params
    super.tap do |p|
      p[:full_response] = emergency.full_response? if p[:resolved_at].present?
    end
  end

  EmergencyDispatch = Struct.new(:emergency) do
    def call
      assign_fire_responders! if emergency.fire_severity > 0
      assign_police_responders! if emergency.police_severity > 0
      assign_medical_responders! if emergency.medical_severity > 0

      self
    end

    private

    def assign_responders!(type, amount)
      # Make a first attempt at finding an exact match
      Responder.where(on_duty: true, emergency: nil, type: type, capacity: amount).first.tap do |responder|
        if responder
          emergency.responders << responder
          return true
        end
      end

      # No exact match, do our best to assign but not overassign
      Responder.where(on_duty: true, emergency: nil, type: type).order(capacity: :desc).tap do |responders|
        responders.each do |responder|
          emergency.responders << responder
          amount -= responder.capacity
          return true if amount <= 0
        end
      end

      false
    end

    def assign_fire_responders!
      assign_responders!("Fire", emergency.fire_severity)
    end

    def assign_police_responders!
      assign_responders!("Police", emergency.police_severity)
    end

    def assign_medical_responders!
      assign_responders!("Medical", emergency.medical_severity)
    end
  end
end
