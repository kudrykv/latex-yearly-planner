# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class LittleCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left'
      }.freeze

      attr_reader :month, :parameters

      def initialize(month:, **parameters)
        @month = month
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters.compact))
      end

      def to_s
        month.moment.to_s
      end
    end
  end
end
