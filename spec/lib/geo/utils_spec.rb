# frozen_string_literal: true

require 'geo/utils'

describe Geo::Utils do
  describe '.foot_to_meter' do
    it 'properly transits foot to meter' do
      expect(described_class.foot_to_meter(12)).to eq(3.65742151782993)
    end
  end
end
