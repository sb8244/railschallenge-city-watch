class Responder < ActiveRecord::Base
  self.inheritance_column = :_type
end
