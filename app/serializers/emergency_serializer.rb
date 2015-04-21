class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :medical_severity, :police_severity, :resolved_at, :responders, :full_response?

  def responders
    object.responders.order(:name).pluck(:name)
  end
end
