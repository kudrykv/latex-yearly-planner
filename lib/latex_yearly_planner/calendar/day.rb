# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Day
      include Comparable

      attr_reader :weekday_start, :moment

      def initialize(weekday_start:, moment:)
        @weekday_start = weekday_start
        @moment = moment
      end

      def id
        "day-#{moment.strftime('%Y-%m-%d')}"
      end

      def day
        moment.day
      end

      def name
        moment.strftime('%A')
      end

      def monday?
        moment.monday?
      end

      def month
        Month.new(weekday_start:, year: moment.year, month: moment.month)
      end

      def cweek
        moment.cweek
      end

      def strftime(format)
        moment.strftime(format)
      end

      def ==(other)
        other.is_a?(Day) && moment == other.moment && weekday_start == other.weekday_start
      end
    end
  end
end
