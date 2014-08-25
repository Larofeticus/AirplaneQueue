require 'spec_helper'

describe Airplane do
  describe 'initialize' do
    it 'raises exception when constructor given a bad size' do
      expect { Airplane.new('bowser', 'cargo') }.to raise_error 
    end
    it 'raises exception when constructor given a bad type' do
      expect { Airplane.new('large', 'jet') }.to raise_error
    end
    it 'returns an Airplane object when given good type and size' do
      expect(Airplane.new('small', 'cargo')).to be_a Airplane 
    end
  end

  describe 'queueKey' do
    it 'returns correct queueKey for Airplane object' do
      expect(Airplane.new('small', 'cargo').queueKey).to eq 'smallcargo'
    end
  end
end
