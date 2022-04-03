# frozen_string_literal: true

require './app/services/normalize_data'

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    Services::NormalizeData.new(dollar_format_file: params[:dollar_format],
                                percent_format_file: params[:percent_format],
                                sort_field: params[:order]).call
  end

  private

  attr_reader :params
end
