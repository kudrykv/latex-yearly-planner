# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Month
      attr_reader :date, :week_start, :show_week_numbers

      def initialize(date, weekday_start: :monday, show_week_numbers: true)
        @date = date
        @week_start = weekday_start
        @show_week_numbers = show_week_numbers
      end
    end
  end
end
