# frozen_string_literal: true

module Services
  class SortData
    def initialize(collection:, sort_field:)
      @collection = collection
      @sort_field = sort_field
    end

    def call
      validation
      sort_collection
    end

    private

    attr_reader :collection, :sort_field

    def validation
      raise 'Collection type not allowed!' unless collection.is_a?(Array)
      raise 'Collection must not be empty!' if collection.empty?
      raise "Only 'PersonStruct types are allowed!" unless collection_of_persons?
    end

    def sort_collection
      sorted = collection.sort_by(&sort_field.to_sym).map(&:values)

      sorted.map! do |item|
        item.join(', ')
      end
    end

    def collection_of_persons?
      collection.all? { |item| item.is_a?(PersonStruct) }
    end
  end
end
