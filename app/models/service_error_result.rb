class ServiceErrorResult
  attr_reader :errors

  def initialize(errors)
    raise "cannot create an error result given a nil error object" if errors.nil?
    raise "cannot create an error result given an empty error object" if errors.empty?
    @errors = errors
  end

  def success?
    false
  end

  def fail?
    !success?
  end

  def map
    self
  end
end
