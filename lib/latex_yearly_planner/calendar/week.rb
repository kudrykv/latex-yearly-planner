# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :days

      def initialize(days)
        @days = days
      end

      def number
        days.compact.map(&:cweek).max
      end
    end
  end
end
