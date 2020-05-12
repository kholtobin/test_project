require 'pry'

require 'validatable'

describe Validatable do
  class User
    include Validatable
    extend ValidatableDSL

    attr_reader :name

    def initialize(name:)
      @name = name
    end
  end

  describe '#valid?' do
    subject { user.valid? }

    context 'with presence validation' do
      before do
        User.instance_variable_set(:@validations, nil)
        User.validate(:name, presence: true)
      end

      context 'when name is nil' do
        let(:user) { User.new(name: nil) }

        it { is_expected.to eq false }
      end

      context 'when name is an empty string' do
        let(:user) { User.new(name: '') }

        it { is_expected.to eq false }
      end

      context 'when name present' do
        let(:user) { User.new(name: 'Nik') }

        it { is_expected.to eq true }
      end
    end

    context 'with format validation' do
      before do
        User.instance_variable_set(:@validations, nil)
        User.validate(:name, format: /^[A-Z]{3,6}$/ )
      end

      context 'when does not match format' do
        let(:user) { User.new(name: '____') }

        it { is_expected.to eq false }
      end

      context 'when matches format' do
        let(:user) { User.new(name: 'NIK') }

        it { is_expected.to eq true }
      end

      context 'when attribute value is nil' do
        let(:user) { User.new(name: nil) }

        it { is_expected.to eq false }
      end
    end

    context 'with type validation' do
      before do
        User.instance_variable_set(:@validations, nil)
        User.validate(:name, type: String)
      end

      context 'when does not match type' do
        let(:user) { User.new(name: 123) }

        it { is_expected.to eq false }
      end

      context 'when matches type' do
        let(:user) { User.new(name: 'nik') }

        it { is_expected.to eq true }
      end
    end
  end
end
