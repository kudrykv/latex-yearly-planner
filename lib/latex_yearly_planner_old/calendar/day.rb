# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Day
      attr_reader :date, :weekday_start

      def initialize(date, weekday_start: nil)
        @date = date
        @weekday_start = weekday_start
      end

      def name
        date.strftime('%A, %-d')
      end

      def month
        Month.new(date.beginning_of_month, weekday_start:)
      end

      def quarter
        Quarter.new(date.beginning_of_quarter, weekday_start:)
      end

      def respond_to_missing?(...)
        date.respond_to?(...)
      end

      def method_missing(...)
        date.send(...)
      end

      def reference
        date.strftime('%Y-%m-%d')
      end

      def ==(other)
        other.is_a?(Day) && date == other.date
      end
    end
  end
end
