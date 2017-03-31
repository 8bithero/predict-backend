class ServiceValueResult
  attr_reader :value
  def initialize(value)
    raise "cannot have a successful result with nil value" if value.nil?
    @value = value
  end

  def success?
    true
  end

  def fail?
    !success?
  end

  def map
    ServiceValueResult.new yield value
  end
end
