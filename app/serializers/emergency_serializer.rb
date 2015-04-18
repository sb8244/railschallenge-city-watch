class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :medical_severity, :police_severity
end
