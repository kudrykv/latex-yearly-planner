# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Quarter
      attr_reader :date, :weekday_start

      def initialize(date, weekday_start: nil)
        @date = date
        @weekday_start = weekday_start
      end

      def ==(other)
        date == other&.date
      end

      def name
        "Q#{number}"
      end

      def number
        (date.mon / 3.0).ceil
      end

      def year
        date.year
      end

      def reference
        "#{year}-#{number}"
      end

      def months
        @months ||= (0..2).map { |month_number| Month.new(date + month_number.month, weekday_start:) }
      end
    end
  end
end
