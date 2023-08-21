# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      WEEKDAYS = %i[sunday monday tuesday wednesday thursday friday saturday].freeze

      attr_reader :date, :weekday_start, :show_week_numbers

      def initialize(date, weekday_start: :monday, show_week_numbers: true)
        @date = date
        @weekday_start = weekday_start
        @show_week_numbers = show_week_numbers
      end

      def name
        date.strftime('%B')
      end

      def weekdays_one_letter
        WEEKDAYS.rotate(WEEKDAYS.find_index(weekday_start)).map { |day| day[0] }.map(&:capitalize)
      end
    end
  end
end
