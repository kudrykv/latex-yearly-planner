# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Quarter
      attr_reader :weekday_start, :year, :number

      def initialize(weekday_start:, year:, number:)
        @weekday_start = weekday_start
        @year = year
        @number = number
      end

      def ==(other)
        other.is_a?(Quarter) &&
          other.weekday_start == weekday_start &&
          other.year == year &&
          other.number == number
      end
    end
  end
end
