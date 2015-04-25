class Responder < ActiveRecord::Base
  self.inheritance_column = :_type

  belongs_to :emergency

  validates :capacity, presence: true
  validates :type, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :capacity, inclusion: { in: 1..5 }

  delegate :emergency_code, to: :emergency, allow_nil: true

  def self.types
    %w(Fire Police Medical)
  end
end
