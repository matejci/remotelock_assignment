# frozen_string_literal: true

require './app/custom_structs/person_struct'
require_relative 'transform_date_format'
require_relative 'city_mapper'
require_relative 'sort_data'

module Services
  class NormalizeData
    def initialize(dollar_format_file:, percent_format_file:, sort_field:)
      @dollar_format_file = dollar_format_file
      @percent_format_file = percent_format_file
      @sort_field = sort_field
    end

    def call
      normalize_collection
    end

    private

    attr_reader :dollar_format_file, :percent_format_file, :sort_field

    def normalize_collection
      dollar_data = parse_file(dollar_format_file, '$')
      percent_data = parse_file(percent_format_file, '%')

      sort_data(dollar_data, percent_data)
    end

    def parse_file(file, delimiter)
      collection = []

      file.each_line.with_index do |line, ind|
        next if ind.zero?

        collection << parse_line(line, delimiter)
      end

      collection
    end

    def parse_line(line, delimiter)
      line_arr = line.chomp.split(" #{delimiter} ")

      obj = PersonStruct.new

      case delimiter
      when '$'
        obj.first_name = line_arr[3]
        obj.city = Services::CityMapper.new(short_name: line_arr[0]).call
        obj.birthdate = transform_date(line_arr[1], delimiter)
      when '%'
        obj.first_name = line_arr[0]
        obj.city = line_arr[1]
        obj.birthdate = transform_date(line_arr[2], delimiter)
      end

      obj
    end

    def transform_date(date_string, delimiter)
      Services::TransformDateFormat.new(date_string: date_string, delimiter: delimiter).call
    end

    def sort_data(dollar_data, percentage_data)
      Services::SortData.new(collection: dollar_data + percentage_data, sort_field: sort_field).call
    end
  end
end
