# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      attr_reader :weekday_start, :moment

      def initialize(weekday_start:, year:, month:)
        @weekday_start = weekday_start
        @moment = Date.new(year, month, 1)
      end
    end
  end
end
