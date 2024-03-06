# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class LittleCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left'
      }.freeze

      attr_reader :month, :parameters

      def initialize(month:, **config)
        @month = month
        @enabled = config.fetch(:enabled, true)
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(config.fetch(:parameters, {}).compact))
      end
    end
  end
end
