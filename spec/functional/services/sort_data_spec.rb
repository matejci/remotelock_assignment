# frozen_string_literal: true

require 'spec_helper'
require './app/custom_structs/person_struct'

RSpec.describe 'SortData Spec' do
  describe 'SortData Service' do
    let(:empty_array) { [] }
    let(:invalid_collection) { ['item1', 2, PersonStruct.new] }
    let(:wrong_collection_type) { nil }
    let(:collection_of_persons) do
      [
        PersonStruct.new('Matej', 'Sarajevo', '4/13/1986'),
        PersonStruct.new('Bruce', 'San Francisco', '11/27/1940'),
        PersonStruct.new('Chuck', 'Ryan', '3/10/1940')
      ]
    end

    it 'raises an exception if collection is empty' do
      service = Services::SortData.new(collection: empty_array, sort_field: :first_name)

      expect { service.call }.to raise_error('Collection must not be empty!')
    end

    it 'raises an exception if collection is invalid' do
      service = Services::SortData.new(collection: invalid_collection, sort_field: :first_name)

      expect { service.call }.to raise_error("Only 'PersonStruct types are allowed!")
    end

    it 'raises an exception if collection is not Array type' do
      service = Services::SortData.new(collection: wrong_collection_type, sort_field: :first_name)

      expect { service.call }.to raise_error('Collection type not allowed!')
    end

    it 'returns sorted collection' do
      service = Services::SortData.new(collection: collection_of_persons, sort_field: :first_name)

      expect(service.call).to eq(['Bruce, San Francisco, 11/27/1940',
                                  'Chuck, Ryan, 3/10/1940',
                                  'Matej, Sarajevo, 4/13/1986'])
    end
  end
end
