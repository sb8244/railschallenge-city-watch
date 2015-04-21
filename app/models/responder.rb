class Responder < ActiveRecord::Base
  self.inheritance_column = :_type

  belongs_to :emergency

  validates_presence_of :name
  validates_presence_of :capacity
  validates_presence_of :type

  validates_uniqueness_of :name

  validates_inclusion_of :capacity, in: 1..5

  def self.types
    ["Fire", "Medical", "Police"]
  end
end
