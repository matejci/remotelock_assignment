# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'TransformDateFormat Spec' do
  describe 'TransformDateFormat Service' do
    let(:dollar_format_date) { '30-4-1974' }
    let(:percentage_format_date) { '1986-05-29' }

    it "returns date format 'M/D/YYYY' if delimiter is $ sign" do
      expect(Services::TransformDateFormat.new(date_string: dollar_format_date, delimiter: '$').call).to eq('4/30/1974')
    end

    it "returns date format 'M/D/YYYY' if delimiter is '%' sign" do
      expect(Services::TransformDateFormat.new(date_string: percentage_format_date, delimiter: '%').call).to eq('5/29/1986')
    end
  end
end
