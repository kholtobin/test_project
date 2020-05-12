class ValidationType
  def initialize(type)
    @type = type
  end

  def call(value)
    value.class == @type
  end

  def error_message
    "Type should be #{@type}"
  end
end
