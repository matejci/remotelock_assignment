# frozen_string_literal: true

module Services
  class TransformDateFormat
    def initialize(date_string:, delimiter:)
      @date_string = date_string
      @delimiter = delimiter
    end

    def call
      transform_date
    end

    private

    attr_reader :date_string, :delimiter

    def transform_date
      date_arr = date_string.split('-')
      delimiter == '$' ? "#{trim_zero(date_arr[1])}/#{trim_zero(date_arr[0])}/#{date_arr[2]}" : "#{trim_zero(date_arr[1])}/#{trim_zero(date_arr[2])}/#{date_arr[0]}"
    end

    def trim_zero(str)
      return str unless str.start_with?('0')

      str.slice(1)
    end
  end
end
