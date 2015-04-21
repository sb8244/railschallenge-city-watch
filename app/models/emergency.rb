class Emergency < ActiveRecord::Base
  has_many :responders

  validates :code, uniqueness: true

  validates :code, presence: true
  validates :medical_severity, presence: true
  validates :fire_severity, presence: true
  validates :police_severity, presence: true

  validates :medical_severity, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, numericality: { greater_than_or_equal_to: 0 }

  def severity_for(type)
    message = "#{type.downcase}_severity".to_sym
    send(message)
  end

  def full_response?
    if resolved_at
      super
    else
      Responder.types.all? do |type|
        responders.where(type: type).sum('capacity') >= severity_for(type)
      end
    end
  end

  def self.full_response_count
    Emergency.where(full_response: true).where.not(resolved_at: nil).count
  end
end
