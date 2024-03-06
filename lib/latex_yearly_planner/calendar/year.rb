# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Year
      attr_reader :weekday_start, :moment

      def initialize(weekday_start:, year:)
        @weekday_start = weekday_start
        @moment = Date.new(year, 1, 1)
      end
    end
  end
end
