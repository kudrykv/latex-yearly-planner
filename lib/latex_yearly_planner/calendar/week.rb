# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :weekday_start, :days

      def initialize(weekday_start:, days:)
        @weekday_start = weekday_start
        @days = days
      end
    end
  end
end
