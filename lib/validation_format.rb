class ValidationFormat
  def initialize(format)
    @format = format
  end

  def call(value)
    !value.nil? && value.match?(@format)
  end

  def error_message
    "Should match format #{@format}"
  end
end
