require 'pry'
require 'validatable_dsl'

module Validatable
  def valid?
    self.class.validations.all? do |attr, arr|
      arr.all? { |validation| validation.call(public_send(attr)) }
    end
  end
end
