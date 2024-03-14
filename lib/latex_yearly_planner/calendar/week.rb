# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :weekday_start, :days

      def initialize(weekday_start:, days:)
        @weekday_start = weekday_start
        @days = days
      end

      def number
        shift = 0
        shift = 1 if days.compact.none?(&:monday?) && days.last.nil?

        days.compact.map(&:cweek).max + shift
      end
    end
  end
end
