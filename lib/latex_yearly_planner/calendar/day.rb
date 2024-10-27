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

      def week
        days = (0...7)
               .map { |i| moment.beginning_of_week(weekday_start).next_day(i) }
               .map { |moment| Day.new(weekday_start:, moment:) }

        Week.new(weekday_start:, days:)
      end

      def name
        moment.strftime('%A')
      end

      def monday?
        moment.monday?
      end

      def month
        @month ||= Month.new(weekday_start:, year: moment.year, month: moment.month)
      end

      def quarter
        @quarter ||= Quarter.new(weekday_start:, year: moment.year, number: moment.quarter)
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
