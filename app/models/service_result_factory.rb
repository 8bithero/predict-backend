class ServiceResultFactory
  def self.from_value(value)
    ServiceValueResult.new(value)
  end

  def self.from_errors(errors)
    ServiceErrorResult.new(errors)
  end

  def self.from_value_and_errors(value, errors)
    if !errors.empty?
      from_errors(errors)
    else
      from_value(value)
    end
  end
end
