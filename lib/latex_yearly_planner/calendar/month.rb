# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      WEEKDAYS = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

      attr_reader :date, :weekday_start

      def initialize(date, weekday_start: :monday)
        @date = date
        @weekday_start = weekday_start
      end

      def name
        date.strftime('%B')
      end

      def weekdays_one_letter
        WEEKDAYS.rotate(WEEKDAYS.find_index(weekday_start)).map { |day| day[0] }.map(&:capitalize)
      end

      def weeks
        date
          .beginning_of_week(weekday_start)
          .upto(date.end_of_month + 7.days)
          .each_slice(7)
          .map { |week| cut_not_our_month(week) }
          .reject { |week| week.all?(&:nil?) }
          .map { |week| Week.new(week) }
      end

      def cut_not_our_month(week)
        week.map { |day| day.mon == date.mon ? day : nil }
      end
    end
  end
end
