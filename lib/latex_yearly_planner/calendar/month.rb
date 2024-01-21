# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      WEEKDAYS = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

      attr_reader :date
      attr_accessor :weekday_start

      def initialize(date, weekday_start: :monday)
        @date = date
        @weekday_start = weekday_start
      end

      def ==(other)
        date == other&.date
      end

      def name
        date.strftime('%B')
      end

      def mon
        date.mon
      end

      def quarter
        Quarter.new(date.beginning_of_quarter, weekday_start:)
      end

      def year
        date.year
      end

      def reference
        "#{year}-#{name}"
      end

      def weekdays_one_letter
        WEEKDAYS.rotate(WEEKDAYS.find_index(weekday_start)).map { |day| day[0] }.map(&:capitalize)
      end

      def weekdays_short
        WEEKDAYS.rotate(WEEKDAYS.find_index(weekday_start)).map { |day| day[0..2] }.map(&:capitalize)
      end

      def weeks
        date
          .beginning_of_week(weekday_start)
          .upto(date.end_of_month + 7.days)
          .each_slice(7)
          .map { |week| cut_not_our_month(week) }
          .reject { |week| week.all?(&:nil?) }
          .map { |week| Week.new(week, weekday_start:) }
      end

      private

      def cut_not_our_month(week)
        week.map { |day| day.mon == date.mon ? day : nil }
      end
    end
  end
end
