class ErrorHash < Hash
  def initialize
    super { |h, k| h[k] = Array.new }
  end

  def add(name, msg)
    self[name.to_sym] << msg
  end
end
