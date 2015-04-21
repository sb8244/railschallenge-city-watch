class ResponderCapacity

  def as_json(options={})
    {}.tap do |resp|
      types.each do |type|
        resp[type] = details(type)
      end
    end
  end

  private

  def types
    ["Fire", "Police", "Medical"]
  end

  def details(type)
    [
        total_capacity(type),
        available_capacity(type),
        on_duty_capacity(type),
        available_on_duty_capacity(type)
    ]
  end

  def total_capacity(type)
    Responder.where(type: type).sum(:capacity)
  end

  def available_capacity(type)
    Responder.where(type: type, emergency: nil).sum(:capacity)
  end

  def on_duty_capacity(type)
    Responder.where(type: type, on_duty: true).sum(:capacity)
  end

  def available_on_duty_capacity(type)
    Responder.where(type: type, on_duty: true, emergency: nil).sum(:capacity)
  end
end
