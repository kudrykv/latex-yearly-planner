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

      def id
        "Q#{year}-#{number}"
      end

      def months
        @months ||= (0..2).map do |month_number|
          Month.new(weekday_start:, year:, month: ((number - 1) * 3) + month_number + 1)
        end
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
