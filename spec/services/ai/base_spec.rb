require 'rails_helper'

RSpec.describe Ai::Base do
  describe '#call' do
    it 'raises a runtime error' do
      expect { described_class.new('prompt').call }.to raise_error(RuntimeError, "Not implemented")
    end
  end
end
