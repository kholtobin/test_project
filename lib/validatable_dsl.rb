module ValidatableDSL
  def validate(attribute, options)
    (validations[attribute] ||= []) << build_validation(*options.first)
  end

  def validations
    @validations ||= {}
  end

  private

  def build_validation(name, option)
    case name
    when :presence
      ->(value) { !value.nil? && !value.empty? }
    when :format
      ->(value) { !value.nil? && value.match?(option) }
    when :type
      ->(value) { value.class == option }
    else
      raise 'Unsupported validation'
    end
  end
end
