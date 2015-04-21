EmergencyDispatch = Struct.new(:emergency) do
  def call
    assign_fire_responders! if emergency.fire_severity > 0
    assign_police_responders! if emergency.police_severity > 0
    assign_medical_responders! if emergency.medical_severity > 0

    self
  end

  private

  def assign_responders!(type, amount)
    return true if assign_exact_responder(type, amount)
    return true if assign_nonexact_responders(type, amount)

    false
  end

  def assign_exact_responder(type, amount)
    Responder.find_by(on_duty: true, emergency: nil, type: type, capacity: amount).tap do |responder|
      if responder
        emergency.responders << responder
        return true
      end
    end

    false
  end

  def assign_nonexact_responders(type, amount)
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
    assign_responders!('Fire', emergency.fire_severity)
  end

  def assign_police_responders!
    assign_responders!('Police', emergency.police_severity)
  end

  def assign_medical_responders!
    assign_responders!('Medical', emergency.medical_severity)
  end
end
