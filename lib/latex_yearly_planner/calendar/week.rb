# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :weekday_start, :days

      def initialize(weekday_start:, days:)
        @weekday_start = weekday_start
        @days = days
      end

      def id
        day = days.compact.first

        "week-#{day.id}"
      end

      def number
        shift = 0
        shift = 1 if days.compact.none?(&:monday?) && days.last.nil?

        days.compact.map(&:cweek).max + shift
      end

      def months
        [days.first.month, days.last.month].uniq
      end

      def ==(other)
        return false unless other.is_a?(Week)

        weekday_start == other.weekday_start && days == other.days
      end
    end
  end
end
