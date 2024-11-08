# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      include Comparable

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
              .reject(&method(:nil_week?))
              .map(&method(:make_week))
      end

      def id
        moment.strftime('%Y-%m')
      end

      def name
        moment.strftime('%B')
      end

      def year
        moment.year
      end

      def quarter
        Quarter.new(weekday_start:, year: moment.year, number: ((moment.month - 1) / 3) + 1)
      end

      def ==(other)
        other.is_a?(Month) && other.moment == moment && other.weekday_start == weekday_start
      end

      def <=>(other)
        return nil unless other.is_a?(Month)

        [moment, weekday_start] <=> [other.moment, other.weekday_start]
      end

      def hash
        [moment, weekday_start].hash
      end

      def first_day
        Day.new(weekday_start:, moment: moment.beginning_of_month)
      end

      def last_day
        Day.new(weekday_start:, moment: moment.end_of_month)
      end

      alias eql? ==

      private

      def nil_week?(days)
        days.all?(&:nil?)
      end

      def make_week(days)
        Week.new(days: days.map(&method(:make_day)), weekday_start:)
      end

      def nil_not_our_month(week)
        week.map { |day| day.month == moment.month ? day : nil }
      end

      def make_day(day)
        return if day.nil?

        Day.new(weekday_start:, moment: day)
      end
    end
  end
end
