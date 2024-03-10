# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      attr_reader :weekday_start, :moment

      def initialize(weekday_start:, year:, month:)
        @weekday_start = weekday_start
        @moment = Date.new(year, month, 1)
      end

      def weeks
        moment.beginning_of_week(weekday_start)
          .upto(moment.end_of_month + 7.days)
          .each_slice(7)
          .map(&method(:nil_not_our_month))
          .reject { |week| week.all?(&:nil?) }
          .map { |week| Week.new(days: week, weekday_start:) }
      end

      private

      def nil_not_our_month(week)
        week.map { |day| day.month == moment.month ? day : nil }
      end
    end
  end
end
