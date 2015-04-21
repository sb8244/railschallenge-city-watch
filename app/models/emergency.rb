class Emergency < ActiveRecord::Base
  has_many :responders

  validates_uniqueness_of :code
  validates_presence_of :code

  validates_presence_of :medical_severity
  validates_presence_of :fire_severity
  validates_presence_of :police_severity

  validates_numericality_of :medical_severity, greater_than_or_equal_to: 0
  validates_numericality_of :fire_severity, greater_than_or_equal_to: 0
  validates_numericality_of :police_severity, greater_than_or_equal_to: 0

  def severity_for(type)
    message = "#{type.downcase}_severity".to_sym
    send(message)
  end

  def full_response?
    if resolved_at
      super
    else
      Responder.types.all? do |type|
        responders.where(type: type).sum("capacity") >= severity_for(type)
      end
    end
  end

  def self.full_response_count
    Emergency.where(full_response: true).where.not(resolved_at: nil).count
  end
end
