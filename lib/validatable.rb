require 'pry'
require 'validatable_dsl'

class ValidationFailure < StandardError
  def initialize(errors)
    @errors = errors
  end

  def message
    @errors
  end
end

module Validatable
  def valid?
    self.class.validations.all? do |attr, arr|
      arr.all? { |validation| validation.call(public_send(attr)) }
    end
  end

  def validate!
    errors = {}
    self.class.validations.each do |attr, arr|
      arr.each do |validation|
        next if validation.call(public_send(attr))

        (errors[attr] ||= []) << validation.error_message
      end
    end

    raise(ValidationFailure, errors) if errors.any?
  end
end
