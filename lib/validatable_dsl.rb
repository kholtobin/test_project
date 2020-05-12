require 'validation_type'
require 'validation_presence'
require 'validation_format'

module ValidatableDSL
  VALIDATIONS = {
    presence: ValidationPresence,
    format: ValidationFormat,
    type: ValidationType
  }.freeze

  def validate(attribute, options)
    (validations[attribute] ||= []) << build_validation(*options.first)
  end

  def validations
    @validations ||= {}
  end

  private

  def build_validation(name, option)
    VALIDATIONS[name]&.new(option) || raise('Unsupported validation')
  end
end
