class Emergency < ActiveRecord::Base
  validates_uniqueness_of :code
  validates_presence_of :code

  validates_presence_of :medical_severity
  validates_presence_of :fire_severity
  validates_presence_of :police_severity

  validates_numericality_of :medical_severity, greater_than_or_equal_to: 0
  validates_numericality_of :fire_severity, greater_than_or_equal_to: 0
  validates_numericality_of :police_severity, greater_than_or_equal_to: 0
end
