class ValidationPresence
  def initialize(_arg)
  end

  def call(value)
    !value.nil? && !value.empty?
  end

  def error_message
    'Should be present'
  end
end
