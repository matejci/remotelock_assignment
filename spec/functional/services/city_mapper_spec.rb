# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'CityMapper Spec' do
  describe 'CityMapper Service' do
    let(:not_existing) { 'SF' }
    let(:existing) { 'NYC' }

    it 'returns nil if short_name does not exists' do
      expect(Services::CityMapper.new(short_name: not_existing).call).to be_nil
    end

    it 'returns long name if short_name exists' do
      expect(Services::CityMapper.new(short_name: existing).call).to eq('New York City')
    end
  end
end
