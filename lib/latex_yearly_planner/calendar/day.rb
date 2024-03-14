# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Day
      attr_reader :weekday_start, :moment

      def initialize(weekday_start:, year:, month:, day:)
        @weekday_start = weekday_start
        @moment = DateTime.new(year, month, day)
      end

      def day
        moment.day
      end

      def monday?
        moment.monday?
      end

      def cweek
        moment.cweek
      end
    end
  end
end
