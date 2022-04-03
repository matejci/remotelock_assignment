# frozen_string_literal: true

module Services
  class CityMapper
    CITIES = { 'NYC' => 'New York City', 'LA' => 'Los Angeles' }.freeze

    def initialize(short_name:)
      @short_name = short_name
    end

    def call
      map_city
    end

    private

    attr_reader :short_name

    def map_city
      CITIES[short_name]
    end
  end
end
